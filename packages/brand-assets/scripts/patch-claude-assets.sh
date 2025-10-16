#!/usr/bin/env bash
set -e

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
for DIR in assets docs/branding .ai-context scripts; do
  if [ -d "$DIR" ]; then
    echo "🚚 Moving $DIR → packages/brand-assets/$DIR"
    run "mkdir -p $(dirname packages/brand-assets/$DIR)"
    run "mv $DIR packages/brand-assets/$DIR"
  else
    echo "⚠️  Skipping $DIR (not found)"
  fi
done

# --- 3. Create Symlinks -----------------------------------------------------
echo "🔗 Creating symlinks..."
run "ln -sf packages/brand-assets/assets assets"
run "ln -sf packages/brand-assets/docs/branding docs/branding"
run "ln -sf packages/brand-assets/.ai-context .ai-context"
run "ln -sf packages/brand-assets/scripts scripts"

# --- 4. Git LFS Setup -------------------------------------------------------
echo "🔗 Configuring Git LFS..."
if ! command -v git-lfs >/dev/null 2>&1; then
  echo "⚠️  Git LFS not installed."
else
  run "git lfs install"
  run "cat > .gitattributes <<'EOF'
*.png filter=lfs diff=lfs merge=lfs -text
*.jpg filter=lfs diff=lfs merge=lfs -text
*.jpeg filter=lfs diff=lfs merge=lfs -text
*.svg filter=lfs diff=lfs merge=lfs -text
*.psd filter=lfs diff=lfs merge=lfs -text
assets/generated/** -filter -diff -merge
EOF"
fi

# --- 5. Update Workspaces ---------------------------------------------------
echo "🧾 Updating package.json workspaces..."
if ! grep -q '"packages/brand-assets"' package.json; then
  run "tmp=\$(mktemp); jq '.workspaces += [\"packages/brand-assets\"]' package.json > \$tmp && mv \$tmp package.json"
fi

# --- 6. Commit Changes ------------------------------------------------------
run "git add ."
run "git commit -m 'chore: integrate Claude brand-assets package [auto-patch]' || echo 'No new changes.'"

# --- 7. Run Setup if Exists -------------------------------------------------
if [ -f "scripts/setup-repo.sh" ]; then
  echo "🚀 Running setup script..."
  run "bash scripts/setup-repo.sh || echo 'Setup completed with warnings.'"
fi

# --- 8. Post-Check Report ---------------------------------------------------
echo ""
echo "🧭 Post-Integration Check"
echo "--------------------------"
echo "📂 Brand assets package contents:"
run "ls -1 packages/brand-assets || echo '(dry-run: not created yet)'"

echo ""
echo "🔗 Symlink status:"
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    echo "✅ $LINK → $(readlink $LINK)"
  else
    echo "⚠️  $LINK missing or not a symlink"
  fi
done

echo ""
echo "🧾 package.json workspace check:"
grep -q '"packages/brand-assets"' package.json && echo "✅ brand-assets listed in workspaces" || echo "⚠️ Missing workspace entry"

echo ""
echo "✅ Patch complete${DRYRUN:+ (dry-run only)}."
echo "Run 'pnpm install && pnpm run setup' to finalize."
