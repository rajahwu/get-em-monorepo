# GTTM Hub - Updated AI Collaboration Handoff

> **Status:** October 15, 2025 - Post-Architecture Update  
> **Change:** Brand assets moved to `packages/brand-assets` workspace package  
> **Impact:** All AI collaborators need to understand new structure

---

## 🏗️ Updated Architecture

### Previous Structure (Root-Level)
```
gttm-hub/
├── assets/
├── docs/branding/
├── .ai-context/
├── scripts/
└── [all other files]
```

### New Structure (Package-Based)
```
gttm-hub/ (monorepo root)
├── apps/
│   ├── blackjack/
│   ├── presentation/
│   └── systems/
│
├── packages/
│   ├── shared-tokens/
│   ├── tailwind-preset/
│   ├── shared-ui/
│   └── brand-assets/          ← NEW: Brand system as a workspace package
│       ├── assets/
│       ├── docs/branding/
│       ├── .ai-context/
│       ├── scripts/
│       ├── package.json       ← Package metadata
│       └── README.md          ← Package-specific docs
│
├── package.json               ← Root workspace config
├── turbo.json                 ← Build orchestration
└── .gitignore, .gitattributes, etc.
```

### Symlinks at Root (For DX)
```
assets/           → packages/brand-assets/assets
docs/branding/    → packages/brand-assets/docs/branding
.ai-context/      → packages/brand-assets/.ai-context
scripts/          → packages/brand-assets/scripts
```

**Why this is better:**
- ✅ Brand assets are a true workspace package (installable, versionable, publishable)
- ✅ Symlinks provide convenient root-level access
- ✅ Separates concerns: brand system is independent from code
- ✅ Can version brand assets independently (`@gttm-hub/brand-assets@1.0.0`)
- ✅ Scales better: other design systems can be added similarly

---

## 📦 New Workspace Configuration

**Root `package.json` workspaces:**
```json
{
  "name": "gttm-hub",
  "workspaces": [
    "apps/*",
    "packages/*"
  ]
}
```

**What this means:**
- `pnpm install` installs all workspace packages
- Each package can have independent dependencies
- `pnpm run [script]` runs across all packages
- `turbo` orchestrates the build pipeline

---

## 🎯 For AI Collaborators: Key Changes

### When Working on Brand Assets

**Old way:**
```bash
# Edit directly in root
code assets/finalized/logos/gttm-logo.svg
code docs/branding/brand-guidelines.md
```

**New way (same result, clearer intent):**
```bash
# Either via symlink (convenient)
code assets/finalized/logos/gttm-logo.svg

# Or explicit package reference (clearer)
code packages/brand-assets/assets/finalized/logos/gttm-logo.svg
```

Both work because of the symlinks, but understanding the underlying structure matters.

### When Installing Dependencies

```bash
# Root install (all packages)
pnpm install

# Install specific package
pnpm --filter @gttm-hub/brand-assets install

# List workspace packages
pnpm ls --depth 0
```

### When Running Scripts

```bash
# Run across all packages
pnpm run setup

# Run in specific package
pnpm --filter @gttm-hub/brand-assets run generate-inventory

# Or with turbo for optimized builds
turbo run build
```

---

## 🔄 Management Scripts (Now Workspace-Aware)

You have several management scripts in `scripts/`:

### 1. **patch-claude-assets.sh**
- Moves assets from root to `packages/brand-assets`
- Creates symlinks for backward compatibility
- Updates `package.json` workspaces
- Runs setup scripts

**When to use:** After merging brand assets from another branch/repo

```bash
./scripts/patch-claude-assets.sh           # Full run
./scripts/patch-claude-assets.sh --dry-run # Preview only
```

### 2. **verify-repo-state.sh**
- Checks symlink health
- Validates workspace configuration
- Confirms Git LFS is active
- Validates tokens and assets

**When to use:** After pulling changes or running patch/rollback

```bash
./scripts/verify-repo-state.sh
```

### 3. **rollback-claude-assets.sh**
- Removes symlinks
- Moves assets back to root
- Cleans up workspace config
- Restores pre-patch structure

**When to use:** If you need to revert the package structure

```bash
./scripts/rollback-claude-assets.sh           # Full rollback
./scripts/rollback-claude-assets.sh --dry-run # Preview only
```

### 4. **manage-claude-assets.sh**
- Interactive menu for all operations
- Includes AI Sync functionality
- Updates `.ai-context/current-project-state.md`
- Best for humans, useful for CI

**When to use:** As your main management tool

```bash
./scripts/manage-claude-assets.sh
# Then select from menu
```

### 5. **github_init.sh**
- Initializes GitHub remote
- Sets up git configuration
- Makes first commit

---

## 📝 AI Context Files Location

All AI context files are now in `packages/brand-assets/.ai-context/`:

```
.ai-context/  (symlinked from root)
├── generation-guidelines.md      # Rules for AI generation
├── current-project-state.md      # Project status (auto-synced)
└── ai-collaboration-handoff.md   # Full handoff document
```

**Important:** When you run `pnpm --filter @gttm-hub/brand-assets run generate-inventory`, it updates the inventory within that package's context.

---

## 🚀 Workflow for AI Collaborators

### Session Start (Updated)

```markdown
Working on GTTM Hub - [Your Task]

**Project Structure:**
- Main monorepo: gttm-hub/
- Brand assets package: packages/brand-assets/ (symlinked at root)
- Token system: packages/shared-tokens/theme.css
- Tailwind preset: packages/tailwind-preset/index.js

**AI Context:**
- Current state: .ai-context/current-project-state.md
- Generation rules: .ai-context/generation-guidelines.md
- File structure: docs/file-structure.md

**My task:** [Be specific]
```

### Sync Before Working

When starting a new session, run:
```bash
./scripts/manage-claude-assets.sh
# Select option 7: AI SYNC
# This updates .ai-context/current-project-state.md with latest repo state
```

Then reference that file to understand:
- Latest git commit
- LFS tracked files count
- Active workspaces
- Recent changes

---

## 🔧 Critical Commands for AIs

### Check Current Structure
```bash
# See symlink status
ls -la | grep -E "assets|docs/branding|.ai-context|scripts"

# Verify workspace packages
pnpm ls --depth 0

# Check brand-assets contents
ls -la packages/brand-assets/
```

### Generate Updated Inventory
```bash
# Via symlink
./scripts/generate-inventory.sh

# Via workspace package
pnpm --filter @gttm-hub/brand-assets run generate-inventory
```

### Verify System Health
```bash
./scripts/verify-repo-state.sh
```

### Sync AI Context
```bash
./scripts/manage-claude-assets.sh
# Select option 7
```

---

## ⚡ For Copilot & ChatGPT: Context Template

```markdown
GTTM Hub Monorepo Update (Oct 15, 2025)

**Architecture Change:**
- Brand assets now in `packages/brand-assets/` workspace package
- Symlinks at root for backward compatibility
- All AI context files moved to `.ai-context/` within package

**Key Paths:**
- Brand tokens: packages/shared-tokens/theme.css
- Asset inventory: docs/branding/asset-inventory.md  
- Current state: .ai-context/current-project-state.md
- Generation rules: .ai-context/generation-guidelines.md

**Commands:**
- Verify health: ./scripts/verify-repo-state.sh
- Sync AI context: ./scripts/manage-claude-assets.sh (option 7)
- Update inventory: ./scripts/generate-inventory.sh

**My task:** [Your specific request]
```

---

## 🎯 Current Project State

**Last Synced:** Oct 15, 2025, 04:44 UTC

### Completed
- ✅ Monorepo structure (turborepo)
- ✅ Shared tokens package
- ✅ Tailwind preset
- ✅ Blackjack trainer app
- ✅ Brand assets integrated as workspace package
- ✅ Management scripts created
- ✅ Symlinks configured for root access
- ✅ Git LFS configured

### In Progress
- ⏳ Verifying symlink health
- ⏳ Testing workspace commands
- ⏳ Documenting new structure for all AIs

### Next Up
1. Confirm all scripts work correctly
2. Run full verification
3. Update AI collaborators with new context
4. Continue asset generation
5. Build shared-ui component library

---

## ⚠️ Important: Breaking Changes for AI

### What Changed for Your Workflows

**Before:**
```bash
code assets/finalized/logos/my-logo.svg
```

**After:**
Same command works! But know it's actually:
```bash
code packages/brand-assets/assets/finalized/logos/my-logo.svg
# symlinked as → assets/finalized/logos/my-logo.svg
```

### Asset Paths Still Work

All these still work because of symlinks:
```bash
assets/                    # symlink active
docs/branding/            # symlink active
.ai-context/              # symlink active
scripts/                  # symlink active
```

### But New Awareness Needed

When committing or reviewing code:
```bash
git status
# You'll see packages/brand-assets/ changes
# This is correct - the package is being versioned

git log --oneline
# You'll see commits mentioning the package
# Example: "chore: integrate Claude brand-assets package [auto-patch]"
```

---

## 🔄 If Symlinks Break

**Symptoms:**
- `assets/` not found
- Scripts in `./scripts/` don't exist
- AI context files missing

**Recovery:**
```bash
# Check symlink status
./scripts/verify-repo-state.sh

# If broken, re-run patch
./scripts/patch-claude-assets.sh

# Or use interactive manager
./scripts/manage-claude-assets.sh
# Select 1 to patch, or 4 to dry-run first
```

---

## 📚 Documentation (Now Package-Local)

All documentation is in `packages/brand-assets/docs/`:

```
packages/brand-assets/docs/branding/
├── brand-guidelines.md
├── prompts.md
├── asset-naming-convention.md
├── asset-workflow.md
├── asset-inventory.md
└── style-guide.html
```

Accessed via symlink: `docs/branding/` (at root)

---

## 🎓 For Your Next Step: Brief Copilot/ChatGPT

When bringing them into this updated structure, use:

```markdown
GTTM Hub Update: Architecture Evolution

We've moved brand assets to a workspace package for better monorepo integration.

**New Structure:**
- Main: gttm-hub/ (turborepo monorepo)
- Brand package: packages/brand-assets/ (workspace package)
- Symlinks: assets/, docs/branding/, .ai-context/, scripts/ (at root)

**For you:**
- All paths still work via symlinks
- Be aware of git showing packages/brand-assets/ changes
- Run ./scripts/verify-repo-state.sh to check health
- Use ./scripts/manage-claude-assets.sh for maintenance

**Documentation:** .ai-context/generation-guidelines.md

This structure lets us:
- Version brand assets independently
- Scale to multiple design systems
- Keep brand system independent but accessible
- Use full monorepo tooling (turbo, pnpm workspaces)

**Current task:** [Your specific request]
```

---

## 🚀 Why This Matters for Long-Term Success

1. **Scalability:** Can add more design system packages later
2. **Independence:** Brand assets can be published as npm package
3. **Versioning:** Track brand changes separately from code
4. **Collaboration:** Clear separation makes AI collaboration easier
5. **Workflow:** Monorepo tooling (turbo, pnpm) handles everything
6. **DX:** Symlinks provide convenience without losing clarity

---

**Next Action:** 
1. Run `./scripts/verify-repo-state.sh` to confirm everything is healthy
2. Run `./scripts/manage-claude-assets.sh` option 7 to sync AI context
3. Brief Copilot and ChatGPT using the template above
4. Continue development with confidence

---

**Last Updated:** October 15, 2025  
**Status:** Architecture Evolved ✅  
**Next Review:** Before next major AI collaboration session