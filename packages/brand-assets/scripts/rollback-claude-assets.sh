#!/usr/bin/env bash
set -e

DRYRUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRYRUN=true
  echo "🧪 Running in DRY-RUN mode — no files will be moved or deleted."
  echo ""
fi

echo "🧹 GTTM Hub — Claude Asset System Rollback"
echo "=========================================="
echo ""

[[ ! -f "package.json" ]] && { echo "❌ Run from repo root."; exit 1; }

read -p "⚠️  Restore original layout? (y/N) " CONFIRM
[[ ! "$CONFIRM" =~ ^[Yy]$ ]] && { echo "❌ Cancelled."; exit 0; }

run() {
  if $DRYRUN; then
    echo "⏩ (dry-run) $*"
  else
    eval "$@"
  fi
}

# --- 1. Remove Symlinks -----------------------------------------------------
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    echo "🪓 Removing symlink $LINK"
    run "rm $LINK"
  fi
done

# --- 2. Move Back -----------------------------------------------------------
if [ -d "packages/brand-assets" ]; then
  echo "🚚 Moving brand-assets contents back to root..."
  cd packages/brand-assets
  for DIR in assets docs/branding .ai-context scripts; do
    if [ -d "$DIR" ]; then
      run "mkdir -p ../../\$(dirname $DIR)"
      run "mv $DIR ../../$DIR"
      echo "✅ Restored $DIR"
    fi
  done
  cd ../..
  run "rm -rf packages/brand-assets"
else
  echo "⚠️  No brand-assets package found — nothing to restore."
fi

# --- 3. Update Workspaces ---------------------------------------------------
echo "🧾 Cleaning workspaces..."
run "tmp=\$(mktemp); jq 'del(.workspaces[] | select(. == \"packages/brand-assets\"))' package.json > \$tmp && mv \$tmp package.json"

# --- 4. Commit Changes ------------------------------------------------------
run "git add ."
run "git commit -m 'revert: remove Claude brand-assets integration [auto-rollback]' || echo 'No changes.'"

# --- 5. Post-Check Report ---------------------------------------------------
echo ""
echo "🧭 Post-Rollback Check"
echo "----------------------"
echo "📂 Root folder presence:"
for F in assets docs .ai-context scripts; do
  if [ -d "$F" ]; then
    echo "✅ $F restored at root"
  else
    echo "⚠️  $F missing"
  fi
done

echo ""
echo "🧾 package.json workspace check:"
grep -q '"packages/brand-assets"' package.json && echo "⚠️  brand-assets still listed in workspaces" || echo "✅ Workspace entry removed"

echo ""
echo "✅ Rollback complete${DRYRUN:+ (dry-run only)}."
