#!/usr/bin/env bash
set -e

# Fixed patch script - properly handles dry-run and symlinks

DRYRUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRYRUN=true
  echo "🧪 Running in DRY-RUN mode — no files will be moved or modified."
  echo ""
fi

echo "🧩 GTTM Hub — Claude Asset System Compatibility Patch"
echo "====================================================="
echo ""

[[ ! -f "package.json" ]] && { echo "❌ Run from repo root."; exit 1; }

run() {
  if $DRYRUN; then
    echo "⏩ (dry-run) $*"
  else
    eval "$@"
  fi
}

# --- 1. Create Package ------------------------------------------------------
echo "📦 Preparing packages/brand-assets..."
run "mkdir -p packages/brand-assets"

# --- 2. Move Folders --------------------------------------------------------
for DIR in assets .ai-context scripts; do
  if [ -d "$DIR" ] && [ ! -L "$DIR" ]; then
    echo "🚚 Moving $DIR → packages/brand-assets/$DIR"
    run "mkdir -p packages/brand-assets"
    run "mv $DIR packages/brand-assets/$DIR"
  elif [ -L "$DIR" ]; then
    echo "✅ $DIR is already a symlink, skipping"
  else
    echo "⚠️  Skipping $DIR (not found)"
  fi
done

# Special handling for docs/branding
if [ -d "docs/branding" ] && [ ! -L "docs/branding" ]; then
  echo "🚚 Moving docs/branding → packages/brand-assets/docs/branding"
  run "mkdir -p packages/brand-assets/docs"
  run "mv docs/branding packages/brand-assets/docs/branding"
elif [ -L "docs/branding" ]; then
  echo "✅ docs/branding is already a symlink, skipping"
else
  echo "⚠️  Skipping docs/branding (not found)"
fi

# --- 3. Create Symlinks (Fix broken ones) -----------------------------------
echo "🔗 Creating/fixing symlinks..."

# Remove broken symlinks first
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ] && [ ! -e "$LINK" ]; then
    echo "🗑️  Removing broken symlink: $LINK"
    run "rm $LINK"
  fi
done

# Create symlinks
run "ln -sf packages/brand-assets/assets assets"
run "ln -sf packages/brand-assets/docs/branding docs/branding"
run "ln -sf packages/brand-assets/.ai-context .ai-context"
run "ln -sf packages/brand-assets/scripts scripts"

# --- 4. Verify Symlinks Created -----------------------------------------------
echo ""
echo "🔗 Verifying symlinks..."
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    TARGET=$(readlink "$LINK")
    if [ -e "$LINK" ]; then
      echo "✅ $LINK → $TARGET (valid)"
    else
      echo "❌ $LINK → $TARGET (BROKEN - target missing!)"
    fi
  else
    echo "❌ $LINK is not a symlink"
  fi
done

# --- 5. Git LFS Setup -------------------------------------------------------
echo ""
echo "🔗 Configuring Git LFS..."
if ! command -v git-lfs >/dev/null 2>&1; then
  echo "⚠️  Git LFS not installed."
else
  run "git lfs install"
  run "cat > .gitattributes <<'EOF'
*.png filter=lfs diff=lfs merge=lfs -text
*.jpg filter=lfs diff=lfs merge=lfs -text
*.jpeg filter=lfs diff=lfs merge=lfs -text
*.gif filter=lfs diff=lfs merge=lfs -text
*.svg filter=lfs diff=lfs merge=lfs -text
*.psd filter=lfs diff=lfs merge=lfs -text
*.mp4 filter=lfs diff=lfs merge=lfs -text
*.mov filter=lfs diff=lfs merge=lfs -text
EOF"
fi

# --- 6. Update Workspaces ---------------------------------------------------
echo "🧾 Updating package.json workspaces..."
if ! grep -q '"packages/brand-assets"' package.json; then
  run "tmp=\$(mktemp); jq '.workspaces += [\"packages/brand-assets\"]' package.json > \$tmp && mv \$tmp package.json"
  echo "✅ Added brand-assets to workspaces"
else
  echo "✅ brand-assets already in workspaces"
fi

# --- 7. Commit Changes ------------------------------------------------------
echo ""
echo "📝 Committing changes..."
if ! $DRYRUN; then
  git add .
  if ! git commit -m "chore: integrate Claude brand-assets package [auto-patch]" 2>/dev/null; then
    echo "ℹ️  No changes to commit or already committed"
  else
    echo "✅ Changes committed"
  fi
fi

# --- 8. Run Setup if Exists -------------------------------------------------
if [ -f "scripts/setup-repo.sh" ]; then
  echo ""
  echo "🚀 Running setup script..."
  if $DRYRUN; then
    echo "⏩ (dry-run) Would run setup script"
  else
    bash scripts/setup-repo.sh || echo "⚠️  Setup completed with warnings."
  fi
fi

# --- 9. Final Status Report -------------------------------------------------
echo ""
echo "🧭 Post-Integration Status"
echo "--------------------------"

echo ""
echo "📂 Brand assets package contents:"
if $DRYRUN; then
  echo "⏩ (dry-run) Would contain:"
else
  if [ -d "packages/brand-assets" ]; then
    ls -1 packages/brand-assets/ | sed 's/^/  /'
  else
    echo "❌ Package directory not found"
  fi
fi

echo ""
echo "🔗 Symlink verification:"
ALL_VALID=true
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    TARGET=$(readlink "$LINK")
    if [ -e "$LINK" ]; then
      echo "✅ $LINK → $TARGET"
    else
      echo "❌ $LINK → $TARGET (BROKEN)"
      ALL_VALID=false
    fi
  elif [ -d "$LINK" ]; then
    echo "⚠️  $LINK exists as directory, not symlink"
  else
    echo "❌ $LINK missing"
    ALL_VALID=false
  fi
done

echo ""
echo "🧾 Workspace configuration:"
if grep -q '"packages/brand-assets"' package.json; then
  echo "✅ brand-assets listed in workspaces"
else
  echo "❌ brand-assets NOT in workspaces"
fi

echo ""
if [ "$ALL_VALID" = true ]; then
  echo "✅ Patch complete and verified${DRYRUN:+ (DRY-RUN: no changes made)}."
  if ! $DRYRUN; then
    echo ""
    echo "Next steps:"
    echo "1. Run: pnpm install"
    echo "2. Run: pnpm run setup"
    echo "3. Run: ./scripts/verify-repo-state.sh"
  fi
else
  echo "❌ Patch has issues - see above for details"
  echo ""
  echo "Troubleshooting:"
  echo "1. Check that packages/brand-assets/ directory exists"
  echo "2. Verify all directories were moved correctly"
  echo "3. Try removing broken symlinks and re-running"
  exit 1
fi
