#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_PUBLIC="$REPO_ROOT/apps/blackjack/public"
TOKENS_DIST="$REPO_ROOT/packages/shared-tokens/dist"
BRAND_OPTIMIZED="$REPO_ROOT/packages/brand-assets/optimized"

mkdir -p "$APP_PUBLIC/css"
# copy token CSS if present
if [ -f "$TOKENS_DIST/theme.css" ]; then
  cp "$TOKENS_DIST/theme.css" "$APP_PUBLIC/css/theme.css"
fi

# copy any shared optimized brand assets if they exist
if [ -d "$BRAND_OPTIMIZED" ]; then
  rsync -a --delete "$BRAND_OPTIMIZED/" "$APP_PUBLIC/assets/"
fi

echo "copied tokens and optimized assets to $APP_PUBLIC"
