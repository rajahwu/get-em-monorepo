#!/usr/bin/env bash
set -e

echo "🚀 Setting up GTTM Hub Repository..."
echo "===================================="

# --- 1. Dependency checks ----------------------------------------------------
if ! command -v git >/dev/null 2>&1; then
  echo "❌ Git is required but not installed. Please install Git and rerun."
  exit 1
fi

if ! command -v git-lfs >/dev/null 2>&1; then
  echo "⚠️  Git LFS not found. Install from https://git-lfs.github.com/"
  echo "   (Skipping LFS setup for now)"
else
  echo "✅ Git LFS detected. Installing hooks..."
  git lfs install
  echo "✅ Tracking large file types..."
  git lfs track "*.png" "*.jpg" "*.jpeg" "*.svg" "*.psd" "*.mp4" "*.mov"
fi

# --- 2. Directory Structure --------------------------------------------------
echo "📂 Ensuring directory structure..."

mkdir -p assets/{source,generated,finalized}
mkdir -p docs/branding
mkdir -p .ai-context
mkdir -p packages/shared-tokens
mkdir -p packages/tailwind-preset

# --- 3. Generate Asset Inventory --------------------------------------------
if [ -f scripts/generate-inventory.sh ]; then
  echo "🧾 Generating asset inventory..."
  bash scripts/generate-inventory.sh
else
  echo "⚠️  Missing generate-inventory.sh — skipping inventory build."
fi

# --- 4. Build Tokens (Copilot Pipeline) -------------------------------------
if [ -f scripts/build-tokens.js ]; then
  echo "🎨 Building design tokens..."
  pnpm run build:tokens || node scripts/build-tokens.js
else
  echo "⚠️  No token parser found — skipping token build."
fi

# --- 5. Confirmation ---------------------------------------------------------
echo ""
echo "✅ GTTM Hub repository setup complete!"
echo "--------------------------------------"
echo "Folders created: assets/, docs/, .ai-context/"
echo "LFS tracked for: images, SVGs, PSDs"
echo "Token build pipeline: Copilot parser active (if configured)"
