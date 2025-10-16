#!/usr/bin/env bash

# Fix symlinks using absolute paths to ensure they work correctly

echo "🔗 GTTM Hub - Symlink Fix (Absolute Paths)"
echo "=========================================="
echo ""

REPO_ROOT="$(pwd)"
BRAND_ASSETS="$REPO_ROOT/packages/brand-assets"

echo "Repository root: $REPO_ROOT"
echo "Brand assets:    $BRAND_ASSETS"
echo ""

# Verify brand-assets exists
if [ ! -d "$BRAND_ASSETS" ]; then
  echo "❌ Error: packages/brand-assets/ not found"
  exit 1
fi

# Check required subdirectories exist
echo "Checking required directories..."
for DIR in assets docs/branding .ai-context scripts; do
  if [ ! -d "$BRAND_ASSETS/$DIR" ]; then
    echo "❌ Missing: $BRAND_ASSETS/$DIR"
    exit 1
  else
    echo "✅ Found: $BRAND_ASSETS/$DIR"
  fi
done

echo ""
echo "Removing old symlinks..."
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    echo "  Removing: $LINK"
    rm "$LINK"
  elif [ -d "$LINK" ]; then
    echo "  ⚠️  $LINK is a real directory, not a symlink (skipping)"
  fi
done

echo ""
echo "Creating symlinks with absolute paths..."

# Create symlinks with absolute paths
ln -v -s "$BRAND_ASSETS/assets" "assets"
ln -v -s "$BRAND_ASSETS/docs/branding" "docs/branding"
ln -v -s "$BRAND_ASSETS/.ai-context" ".ai-context"
ln -v -s "$BRAND_ASSETS/scripts" "scripts"

echo ""
echo "Verifying symlinks..."
echo ""

ALL_GOOD=true
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    TARGET=$(readlink "$LINK")
    if [ -e "$LINK" ]; then
      echo "✅ $LINK"
      echo "   → $TARGET"
    else
      echo "❌ $LINK (BROKEN)"
      echo "   → $TARGET"
      ALL_GOOD=false
    fi
  else
    echo "❌ $LINK (not a symlink)"
    ALL_GOOD=false
  fi
done

echo ""
if [ "$ALL_GOOD" = true ]; then
  echo "✅ All symlinks are valid!"
else
  echo "❌ Some symlinks are still broken"
  exit 1
fi
