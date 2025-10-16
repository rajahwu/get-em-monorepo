#!/bin/bash

# Generate Asset Inventory
# Automatically scans assets directory and updates inventory

INVENTORY_FILE="docs/branding/asset-inventory.md"
DATE=$(date +%Y-%m-%d)

# Count assets
SVG_COUNT=$(find assets/source/svg -name "*.svg" 2>/dev/null | wc -l)
HTML_COUNT=$(find assets/source/html -name "*.html" 2>/dev/null | wc -l)
FINALIZED_COUNT=$(find assets/finalized -type f 2>/dev/null | wc -l)
TOTAL=$((SVG_COUNT + HTML_COUNT + FINALIZED_COUNT))

# Generate header
cat > "$INVENTORY_FILE" << HEADER
# GTTM Asset Inventory

> Last Updated: $DATE
> Total Assets: $TOTAL

## 📂 Assets by Category

HEADER

# List SVG sources
echo "### SVG Source Files ($SVG_COUNT)" >> "$INVENTORY_FILE"
if [ $SVG_COUNT -gt 0 ]; then
    find assets/source/svg -name "*.svg" | sort | sed 's/^/- /' >> "$INVENTORY_FILE"
else
    echo "*No SVG files yet*" >> "$INVENTORY_FILE"
fi
echo "" >> "$INVENTORY_FILE"

# List HTML templates
echo "### HTML Templates ($HTML_COUNT)" >> "$INVENTORY_FILE"
if [ $HTML_COUNT -gt 0 ]; then
    find assets/source/html -name "*.html" | sort | sed 's/^/- /' >> "$INVENTORY_FILE"
else
    echo "*No HTML templates yet*" >> "$INVENTORY_FILE"
fi
echo "" >> "$INVENTORY_FILE"

# List finalized assets by category
echo "### Finalized Assets ($FINALIZED_COUNT)" >> "$INVENTORY_FILE"
echo "" >> "$INVENTORY_FILE"

for category in brand ui social game marketing screenshots; do
    COUNT=$(find "assets/finalized/$category" -type f 2>/dev/null | wc -l)
    echo "#### $(echo $category | sed 's/.*/\u&/') ($COUNT)" >> "$INVENTORY_FILE"
    if [ $COUNT -gt 0 ]; then
        find "assets/finalized/$category" -type f | sort | sed 's/^/- /' >> "$INVENTORY_FILE"
    else
        echo "*No assets yet*" >> "$INVENTORY_FILE"
    fi
    echo "" >> "$INVENTORY_FILE"
done

# Add footer
cat >> "$INVENTORY_FILE" << FOOTER

## 📊 Summary

- **SVG Sources:** $SVG_COUNT
- **HTML Templates:** $HTML_COUNT
- **Finalized Assets:** $FINALIZED_COUNT
- **Total:** $TOTAL

---

*Auto-generated on $DATE by generate-inventory.sh*
FOOTER

echo "✓ Asset inventory updated: $TOTAL total assets"
