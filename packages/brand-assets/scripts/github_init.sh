# create or overwrite .gitignore with the content above (example using a heredoc)
cat > .gitignore <<'EOF'
# Node and pnpm
node_modules/
.pnp.*
.pnpm-debug.log
pnpm-lock.yaml

# Build outputs
dist/
build/
.vite/
out/
coverage/

# TypeScript
*.tsbuildinfo
*.d.ts

# Vite / dev
.env
.env.local
.env.*.local
.vs/
.cache/

# Editors and OS
.vscode/
.idea/
.DS_Store
Thumbs.db

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Packages and temp
*.tgz
*.log

# Storybook
.storybook-static/

# Generated assets
*.map
EOF

# Initialize git if not already
git init
git checkout -b main

# Stage and commit
git add .
git commit -m "chore: initial commit — repo scaffold, configs, packages, apps, shared-ui"

# Add remote (replace if needed)
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:rajahwu/get-em-monorepo.git

# Push
git push -u origin main
