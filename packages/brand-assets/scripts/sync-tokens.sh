#!/usr/bin/env bash
set -e

echo "🎨 Syncing design tokens into AI context..."

CSS_FILE="packages/shared-tokens/theme.css"
JSON_FILE=".ai-context/theme-tokens.json"

if [ ! -f "$CSS_FILE" ]; then
  echo "❌ Missing $CSS_FILE"
  exit 1
fi

mkdir -p .ai-context

# Extract CSS custom properties into JSON
node - <<'EOF'
import fs from "fs";

const css = fs.readFileSync("packages/shared-tokens/theme.css", "utf8");
const regex = /--([\w-]+):\s*([^;]+);/g;
const tokens = {};
let match;
while ((match = regex.exec(css))) {
  tokens[match[1]] = match[2].trim();
}
fs.writeFileSync(".ai-context/theme-tokens.json", JSON.stringify(tokens, null, 2));
console.log("✅ Tokens exported to .ai-context/theme-tokens.json");
EOF

# Append summary to AI context state
echo -e "\n### Token Sync — $(date)\n" >> .ai-context/current-project-state.md
echo "\`\`\`json" >> .ai-context/current-project-state.md
cat "$JSON_FILE" >> .ai-context/current-project-state.md
echo "\`\`\`" >> .ai-context/current-project-state.md

echo "✅ Tokens synced into AI context snapshot."
