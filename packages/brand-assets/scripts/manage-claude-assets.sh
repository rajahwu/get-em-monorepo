#!/usr/bin/env bash
set -e

echo ""
echo "🎛️  GTTM Hub — Claude Asset System Manager"
echo "=========================================="
echo ""

ROOT_DIR=$(pwd)
SCRIPTS_DIR="$ROOT_DIR/scripts"

PATCH_SCRIPT="$SCRIPTS_DIR/patch-claude-assets.sh"
ROLLBACK_SCRIPT="$SCRIPTS_DIR/rollback-claude-assets.sh"
VERIFY_SCRIPT="$SCRIPTS_DIR/verify-repo-state.sh"
AICONTEXT_FILE=".ai-context/current-project-state.md"

# --- 1. Prerequisite Checks -------------------------------------------------
for FILE in "$PATCH_SCRIPT" "$ROLLBACK_SCRIPT" "$VERIFY_SCRIPT"; do
  if [ ! -f "$FILE" ]; then
    echo "❌ Missing required script: $(basename $FILE)"
    echo "Please ensure all required scripts are in $SCRIPTS_DIR/"
    exit 1
  fi
done

# --- 2. Helper Functions ----------------------------------------------------
run_ai_sync() {
  echo ""
  echo "🤖 Running AI Sync..."
  echo "----------------------------------------------------"

  if [ ! -d ".ai-context" ]; then
    echo "📁 Creating .ai-context directory..."
    mkdir -p .ai-context
  fi

  mkdir -p "$(dirname "$AICONTEXT_FILE")"

  echo "🧠 Updating $AICONTEXT_FILE ..."
  {
    echo "# Current Project State"
    echo "_Auto-synced on $(date)_"
    echo ""
    echo "## Repository Snapshot"
    echo "- **Branch:** $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'unknown')"
    echo "- **Latest Commit:** $(git log -1 --pretty=format:'%h — %s (%cr)' 2>/dev/null || echo 'none')"
    echo "- **LFS Tracked Files:** $(git lfs ls-files | wc -l 2>/dev/null || echo '0')"
    echo "- **Tokens File:** $( [ -f packages/shared-tokens/theme.css ] && echo '✅ Found' || echo '⚠️ Missing')"
    echo "- **Assets Folder:** $( [ -d assets ] && echo '✅ Present' || echo '⚠️ Missing')"
    echo ""
    echo "## Active Workspaces"
    jq -r '.workspaces[]?' package.json 2>/dev/null || echo "(no workspace data)"
    echo ""
    echo "## Recent Commits"
    git log -n 5 --pretty=format:"- %h %s (%cr)" 2>/dev/null || echo "⚠️ Git log unavailable"
    echo ""
    echo "## AI Sync Notes"
    echo "This snapshot helps AI collaborators align on project state, brand asset versions, and token changes."
  } > "$AICONTEXT_FILE"

  echo ""
  echo "🧾 AI Context Updated → $AICONTEXT_FILE"

  echo ""
  echo "📦 Committing AI sync checkpoint..."

  # Resolve symlink to real path
  REAL_PATH=$(readlink -f "$AICONTEXT_FILE")

  if [ -f "$REAL_PATH" ]; then
    git add "$REAL_PATH"
    git commit -m "chore(ai): sync project state [auto-sync]" || echo "⚠️ No changes to commit"
  else
    echo "❌ Could not find resolved AI context file at $REAL_PATH"
  fi
  
  echo ""
  echo "✅ AI Sync Complete — AI collaborators are now up-to-date."
}

# --- 3. Main Menu -----------------------------------------------------------
while true; do
  echo ""
  echo "Select an operation:"
  echo "1️⃣  Run PATCH         – integrate Claude’s brand-assets system"
  echo "2️⃣  Run ROLLBACK      – restore pre-merge structure"
  echo "3️⃣  Run VERIFY        – check repo integrity"
  echo "4️⃣  Dry-run PATCH"
  echo "5️⃣  Dry-run ROLLBACK"
  echo "6️⃣  Exit"
  echo "7️⃣  🤖 AI SYNC        – update .ai-context/current-project-state.md"
  echo ""
  read -p "Enter your choice [1-7]: " CHOICE
  echo ""

  case $CHOICE in
    1)
      echo "🚀 Running full PATCH..."
      bash "$PATCH_SCRIPT"
      ;;
    2)
      echo "🧹 Running full ROLLBACK..."
      bash "$ROLLBACK_SCRIPT"
      ;;
    3)
      echo "🔍 Running VERIFY..."
      bash "$VERIFY_SCRIPT"
      ;;
    4)
      echo "🧪 Running PATCH in dry-run mode..."
      bash "$PATCH_SCRIPT" --dry-run
      ;;
    5)
      echo "🧪 Running ROLLBACK in dry-run mode..."
      bash "$ROLLBACK_SCRIPT" --dry-run
      ;;
    6)
      echo "👋 Exiting manager. No changes made."
      exit 0
      ;;
    7)
      run_ai_sync
      ;;
    *)
      echo "❌ Invalid selection. Please choose 1–7."
      ;;
  esac

  echo ""
  read -p "Press Enter to return to the menu or Ctrl+C to quit."
  clear
  echo ""
  echo "🎛️  GTTM Hub — Claude Asset System Manager"
  echo "=========================================="
done
