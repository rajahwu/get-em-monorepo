#!/usr/bin/env bash
set -e

echo ""
echo "🔍 GTTM Hub — Repository Integrity Verification"
echo "==============================================="
echo ""

[[ ! -f "package.json" ]] && { echo "❌ Run this from the monorepo root."; exit 1; }

# --- 1. Directory Health ----------------------------------------------------
echo "📂 Directory Structure:"
for DIR in apps packages docs assets .ai-context scripts; do
  if [ -d "$DIR" ]; then
    echo "✅ $DIR found"
  else
    echo "⚠️  Missing directory: $DIR"
  fi
done
echo ""

# --- 2. Symlink Validation --------------------------------------------------
echo "🔗 Symlink Check:"
SYMLINKS=("assets" "docs/branding" ".ai-context" "scripts")
BROKEN_SYMLINKS=false
for LINK in "${SYMLINKS[@]}"; do
  if [ -L "$LINK" ]; then
    TARGET=$(readlink "$LINK")
    if [ -e "$LINK" ]; then
      echo "✅ $LINK → $TARGET"
    else
      echo "❌ $LINK is broken → $TARGET"
      BROKEN_SYMLINKS=true
    fi
  fi
done
echo ""

# --- 3. Git LFS Validation --------------------------------------------------
echo "🧱 Git LFS Status:"
if command -v git-lfs >/dev/null 2>&1; then
  git lfs install >/dev/null
  LFS_COUNT=$(git lfs ls-files | wc -l)
  echo "✅ Git LFS active ($LFS_COUNT files tracked)"
else
  echo "⚠️  Git LFS not installed"
fi
echo ""

# --- 4. Workspace Integrity -------------------------------------------------
echo "🧾 Workspace Check:"
if grep -q '"packages/brand-assets"' package.json; then
  echo "✅ brand-assets listed in workspaces"
else
  echo "⚠️  brand-assets workspace missing (expected if rolled back)"
fi

# Check for basic workspace references
jq '.workspaces' package.json >/dev/null 2>&1 || echo "⚠️  No workspace configuration found in package.json"
echo ""

# --- 5. Token and Asset Validation -----------------------------------------
echo "🎨 Design Tokens & Assets:"
if [ -f "packages/shared-tokens/theme.css" ]; then
  TOKEN_COUNT=$(grep -c -- '--color-' packages/shared-tokens/theme.css || true)
  echo "✅ Found $TOKEN_COUNT tokens in theme.css"
else
  echo "⚠️  Missing packages/shared-tokens/theme.css"
fi

if [ -f "docs/branding/asset-inventory.md" ]; then
  ASSET_COUNT=$(grep -c '\.png\|\.svg' docs/branding/asset-inventory.md || true)
  echo "✅ Asset inventory found ($ASSET_COUNT entries)"
else
  echo "⚠️  Missing docs/branding/asset-inventory.md"
fi
echo ""

# --- 6. AI Context Validation ----------------------------------------------
echo "🤖 AI Context Files:"
if [ -d ".ai-context" ]; then
  ls -1 .ai-context | grep '\.md$' || echo "⚠️  No AI context markdown files"
else
  echo "⚠️  .ai-context directory missing"
fi
echo ""

# --- 7. Summary Report ------------------------------------------------------
echo "🧭 Summary:"
[[ "$BROKEN_SYMLINKS" == true ]] && echo "❌ Broken symlinks detected" || echo "✅ All symlinks valid"
[[ -d "packages/brand-assets" ]] && echo "✅ brand-assets package present" || echo "⚠️ brand-assets package not found"
[[ -f "scripts/setup-repo.sh" ]] && echo "✅ setup-repo.sh exists" || echo "⚠️ setup-repo.sh missing"

echo ""
echo "📜 Recommendations:"
echo "- Run 'pnpm install' if workspace links are broken."
echo "- Run 'pnpm run setup' to regenerate tokens and inventory."
echo "- Re-run this check after major merges or CI builds."
echo ""
echo "✅ Verification complete."
