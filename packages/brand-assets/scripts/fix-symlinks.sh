#!/usr/bin/env bash

# Diagnostic script to understand and fix the symlink issue

echo "🔍 GTTM Hub - Symlink Diagnostic"
echo "=================================="
echo ""

# Step 1: Check what exists
echo "Step 1: What actually exists?"
echo "----------------------------"
echo ""
echo "At root level:"
ls -la | grep -E "^l.*docs|^d.*docs"

echo ""
echo "In packages/brand-assets/:"
if [ -d "packages/brand-assets" ]; then
  ls -la packages/brand-assets/ | grep -v "^total"
else
  echo "❌ packages/brand-assets/ does not exist!"
fi

echo ""
echo "In packages/brand-assets/docs/:"
if [ -d "packages/brand-assets/docs" ]; then
  ls -la packages/brand-assets/docs/
else
  echo "❌ packages/brand-assets/docs/ does not exist!"
fi

echo ""
echo "In packages/brand-assets/docs/branding/:"
if [ -d "packages/brand-assets/docs/branding" ]; then
  ls -la packages/brand-assets/docs/branding/ | head -10
else
  echo "❌ packages/brand-assets/docs/branding/ does not exist!"
fi

# Step 2: Check symlink targets
echo ""
echo "Step 2: Current symlinks and their targets"
echo "------------------------------------------"
echo ""
for LINK in assets docs/branding .ai-context scripts; do
  if [ -L "$LINK" ]; then
    TARGET=$(readlink "$LINK")
    REAL_PATH=$(readlink -f "$LINK" 2>/dev/null || echo "N/A")
    if [ -e "$LINK" ]; then
      echo "✅ $LINK → $TARGET (valid, target exists)"
    else
      echo "❌ $LINK → $TARGET (BROKEN, target missing)"
    fi
  elif [ -d "$LINK" ]; then
    echo "📁 $LINK is a real directory"
  else
    echo "❌ $LINK does not exist"
  fi
done

# Step 3: Recommend fix
echo ""
echo "Step 3: Recommended Fix"
echo "-----------------------"
echo ""

if [ ! -d "packages/brand-assets/docs/branding" ]; then
  echo "Creating missing directories..."
  echo "  mkdir -p packages/brand-assets/docs/branding"
  echo ""
fi

echo "Removing broken symlinks..."
for LINK in docs/branding; do
  if [ -L "$LINK" ] && [ ! -e "$LINK" ]; then
    echo "  rm $LINK"
  fi
done

echo ""
echo "Creating correct symlinks..."
echo "  ln -sf packages/brand-assets/assets assets"
echo "  ln -sf packages/brand-assets/docs/branding docs/branding"
echo "  ln -sf packages/brand-assets/.ai-context .ai-context"
echo "  ln -sf packages/brand-assets/scripts scripts"

echo ""
echo "Step 4: Run this fix? (y/n)"
read -p "> " FIX

if [[ "$FIX" == "y" ]]; then
  echo ""
  echo "Applying fix..."
  
  # Create missing dirs
  mkdir -p packages/brand-assets/docs/branding
  
  # Remove broken symlinks
  for LINK in assets docs/branding .ai-context scripts; do
    if [ -L "$LINK" ] && [ ! -e "$LINK" ]; then
      echo "Removing broken: $LINK"
      rm "$LINK"
    elif [ -L "$LINK" ] && [ -e "$LINK" ]; then
      echo "Already valid: $LINK"
    fi
  done
  
  # Create correct symlinks
  ln -sf packages/brand-assets/assets assets
  ln -sf packages/brand-assets/docs/branding docs/branding
  ln -sf packages/brand-assets/.ai-context .ai-context
  ln -sf packages/brand-assets/scripts scripts
  
  echo ""
  echo "Fix applied. Verifying..."
  echo ""
  
  for LINK in assets docs/branding .ai-context scripts; do
    if [ -L "$LINK" ]; then
      TARGET=$(readlink "$LINK")
      if [ -e "$LINK" ]; then
        echo "✅ $LINK → $TARGET (valid)"
      else
        echo "❌ $LINK → $TARGET (still broken!)"
      fi
    else
      echo "❌ $LINK not a symlink"
    fi
  done
  
  echo ""
  echo "Done!"
else
  echo "Fix cancelled."
fi
