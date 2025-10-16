#!/bin/bash

# Export Bundle
# Create a release package of all finalized assets

VERSION=${1:-"v1.0"}
DATE=$(date +%Y%m%d)
BUNDLE_NAME="gttm-brand-assets-$VERSION-$DATE"

echo "Creating asset bundle: $BUNDLE_NAME"

# Create temporary directory
mkdir -p "dist/$BUNDLE_NAME"

# Copy finalized assets
cp -R assets/finalized/* "dist/$BUNDLE_NAME/"

# Copy documentation
mkdir -p "dist/$BUNDLE_NAME/documentation"
cp docs/branding/*.md "dist/$BUNDLE_NAME/documentation/"
cp docs/branding/*.html "dist/$BUNDLE_NAME/documentation/" 2>/dev/null || true

# Create README for bundle
cat > "dist/$BUNDLE_NAME/README.md" << README
# GTTM Brand Assets - $VERSION

Release Date: $(date +%Y-%m-%d)

## Contents

This package contains production-ready brand assets for GTTM Hub:

- \`brand/\` - Logos, favicons, patterns
- \`ui/\` - Icons and UI components
- \`social/\` - Social media templates
- \`game/\` - Game-specific assets
- \`marketing/\` - Marketing materials
- \`documentation/\` - Brand guidelines and usage docs

## Usage

Refer to the documentation folder for:
- Brand guidelines
- Naming conventions
- Usage examples
- Color specifications

## Questions?

Visit: https://github.com/[your-username]/gttm-hub

© 2025 GTTM Hub. All rights reserved.
README

# Create zip archive
cd dist
zip -r "$BUNDLE_NAME.zip" "$BUNDLE_NAME"
cd ..

echo "✓ Bundle created: dist/$BUNDLE_NAME.zip"
echo ""
echo "To create a GitHub release:"
echo "gh release create $VERSION dist/$BUNDLE_NAME.zip --title 'Brand Assets $VERSION' --notes 'Release notes here'"
