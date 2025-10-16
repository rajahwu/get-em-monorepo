# GTTM Hub - Day 1 Integration Checklist

> Goal: Merge the brand system with your existing codebase in one organized session
> 
> 
> **Time Estimate:** 2-3 hours
> 
> **Date:** October 14, 2025
> 

---

## ✅ Phase 1: Setup & Organization (30 min)

### Step 1: Run the Setup Script

```bash
# Save the setup script from artifacts
nano setup-gttm.sh
# Paste content, Ctrl+X, Y, Enter

# Make executable
chmod +x setup-gttm.sh

# Run in PARENT directory of your existing gttm-hub
cd /path/to/parent/
./setup-gttm.sh

# When prompted, enter: gttm-hub-brand
# This creates a parallel structure we'll merge

```

- [ ]  Setup script completed successfully
- [ ]  New directory created with all structure

### Step 2: Copy Artifacts to New Structure

```bash
cd gttm-hub-brand

# Copy documentation
code docs/branding/brand-guidelines.md
# Paste your full brand guidelines

code docs/branding/prompts.md
# Paste the prompts library

code docs/branding/asset-naming-convention.md
# Paste naming convention

code docs/branding/asset-workflow.md
# Paste workflow guide

# Copy HTML assets
code assets/source/html/style-guide.html
# Paste interactive style guide

code assets/source/html/social-templates.html
# Paste social templates

code assets/source/html/quick-reference.html
# Paste quick reference

# Copy SVG assets
code assets/source/svg/gttm-logo-concepts.svg
# Paste logo concepts

code assets/source/svg/gttm-icons-favicons.svg
# Paste icon library

```

- [ ]  All markdown docs copied
- [ ]  All HTML files saved
- [ ]  All SVG files saved

### Step 3: Copy AI Context to Existing Repo

```bash
# Navigate to your ACTUAL codebase
cd ../gttm-hub  # Your existing repo

# Create .ai-context directory
mkdir -p .ai-context

# Copy the AI context files
cp ../gttm-hub-brand/.ai-context/* .ai-context/

# Also copy the brand docs
mkdir -p docs/branding
cp ../gttm-hub-brand/docs/branding/* docs/branding/

# And copy assets structure
mkdir -p assets
cp -r ../gttm-hub-brand/assets/* assets/

```

- [ ]  `.ai-context/` created in main repo
- [ ]  `docs/branding/` created in main repo
- [ ]  `assets/` created in main repo

---

## ✅ Phase 2: Documentation Integration (20 min)

### Step 4: Create Main Handoff Documents

```bash
cd gttm-hub  # Your main repo

# Create the AI handoff document
code .ai-context/ai-collaboration-handoff.md
# Paste the full handoff document from artifacts

# Create quick start guide
code .ai-context/ai-quickstart.md
# Paste the quick start context

# Create file structure doc
code docs/file-structure.md
# Paste the complete file structure document

# Update current project state
code .ai-context/current-project-state.md
# Update the date and status to reflect today

```

**Update current-project-state.md with:**

```markdown
**Last Updated:** 2025-10-14
**Phase:** Brand System Integration
**Status:** Merging brand assets with existing codebase

## Completed ✅
- ✅ Blackjack trainer (fully functional)
- ✅ Monorepo structure (turborepo)
- ✅ Design tokens package
- ✅ Tailwind preset
- ✅ Brand guidelines complete
- ✅ AI prompt library
- ✅ Asset naming convention
- ✅ Initial brand assets (logos, icons, templates)
- ✅ AI collaboration documents

## In Progress ⏳
- [ ] Integrating brand assets into apps
- [ ] Auditing code for brand compliance
- [ ] Creating shared UI component library

```

- [ ]  Handoff document created
- [ ]  Quick start created
- [ ]  File structure documented
- [ ]  Current state updated

### Step 5: Update Main README

```bash
code README.md

```

Add at the top:

```markdown
# GTTM Hub - Get 'Em Platform

> **Train Smarter. Play Harder.**

A modular platform fusing gaming, technical training, and creative systems thinking.

## 🚀 Quick Start

\`\`\`bash
npm install
npm run dev
\`\`\`

## 🤖 For AI Collaborators

**Start here:** `.ai-context/ai-quickstart.md`
**Full context:** `.ai-context/ai-collaboration-handoff.md`
**File map:** `docs/file-structure.md`

## 📚 Documentation

- [Brand Guidelines](docs/branding/brand-guidelines.md)
- [AI Prompts](docs/branding/prompts.md)
- [Asset Naming](docs/branding/asset-naming-convention.md)
- [Interactive Style Guide](docs/branding/style-guide.html)

## 🎨 Brand Identity

**Colors:** Electric Indigo (#5A4BFF), Aqua Mint (#00E6A8), Void Black (#0F1117)
**Style:** Flat minimalist, dark-first, high contrast
**Tokens:** `packages/shared-tokens/theme.css`

[Rest of your existing README...]

```

- [ ]  README updated with AI links
- [ ]  Brand identity section added

---

## ✅ Phase 3: Token Audit & Update (30 min)

### Step 6: Audit Design Tokens

```bash
code packages/shared-tokens/theme.css

```

**Ensure these tokens exist:**

```css
:root {
  /* Brand Colors */
  --color-brand: #5A4BFF;
  --color-accent: #00E6A8;

  /* Surfaces */
  --color-surface: #0F1117;
  --color-surface-alt: #161A22;
  --color-border: #2A2E37;

  /* Text */
  --color-text: #FFFFFF;
  --color-text-muted: #A0AEC0;
  --color-text-inverse: #0F1117;

  /* Semantic States */
  --color-success: #00E6A8;
  --color-warning: #FFCAB1;
  --color-error: #E05263;
  --color-info: #5A4BFF;

  /* Spacing (if not already defined) */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;
}

```

- [ ]  All brand colors present
- [ ]  Semantic colors added
- [ ]  Token comments added for clarity

### Step 7: Update Tailwind Preset

```bash
code packages/tailwind-preset/index.js

```

**Ensure all tokens are mapped:**

```jsx
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: 'var(--color-brand)',
        accent: 'var(--color-accent)',
        surface: {
          DEFAULT: 'var(--color-surface)',
          alt: 'var(--color-surface-alt)',
        },
        border: 'var(--color-border)',
        success: 'var(--color-success)',
        warning: 'var(--color-warning)',
        error: 'var(--color-error)',
        info: 'var(--color-info)',
      },
    },
  },
  plugins: [],
};

```

- [ ]  All colors mapped to Tailwind
- [ ]  Preset exports correctly

---

## ✅ Phase 4: Code Audit (45 min)

### Step 8: Audit Blackjack App Components

```bash
# Review each component file
code apps/blackjack/src/App.jsx
code apps/blackjack/src/components/*.jsx

```

**For each file, check:**

1. **Hardcoded colors?**
    - [ ]  Search for `#` (hex codes)
    - [ ]  Replace with `var(--color-*)` or Tailwind classes
2. **Shadows or gradients?**
    - [ ]  Search for `shadow`, `box-shadow`, `gradient`
    - [ ]  Remove unless it's the brand gradient
3. **Accessibility?**
    - [ ]  Proper ARIA labels on buttons
    - [ ]  Semantic HTML tags
    - [ ]  Keyboard navigation support

**Example fixes:**

```jsx
// BEFORE
<button style={{ backgroundColor: '#5A4BFF' }}>Hit</button>

// AFTER
<button className="bg-brand hover:opacity-90">Hit</button>

// OR
<button style={{ background: 'var(--color-brand)' }}>Hit</button>

```

- [ ]  App.jsx audited and fixed
- [ ]  All component files audited
- [ ]  No hardcoded colors remain
- [ ]  No unauthorized shadows/gradients

### Step 9: Update index.css

```bash
code apps/blackjack/src/index.css

```

**Ensure it imports tokens:**

```css
@import '@gttm-hub/shared-tokens/theme.css';
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Any custom global styles */
body {
  background: var(--color-surface);
  color: var(--color-text);
}

```

- [ ]  Token import added
- [ ]  Global styles use tokens

---

## ✅ Phase 5: Asset Integration (30 min)

### Step 10: Add Favicon

```bash
# Copy favicon to public folder
cp assets/finalized/brand/favicons/gttm-favicon-32.png apps/blackjack/public/favicon.ico

# Update index.html
code apps/blackjack/index.html

```

Add to `<head>`:

```html
<link rel="icon" type="image/png" sizes="32x32" href="/favicon.ico">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">

<!-- Meta tags -->
<meta name="theme-color" content="#5A4BFF">
<meta name="description" content="GTTM Hub - Train Smarter. Play Harder.">

<!-- Open Graph -->
<meta property="og:title" content="GTTM Hub - Blackjack Trainer">
<meta property="og:description" content="Train Smarter. Play Harder.">
<meta property="og:type" content="website">

```

- [ ]  Favicon added
- [ ]  Meta tags updated
- [ ]  Theme color set

### Step 11: Test the App

```bash
# Start dev server
npm run dev

# Open in browser and check:

```

- [ ]  App loads without errors
- [ ]  Colors match brand palette
- [ ]  No console errors
- [ ]  Favicon appears
- [ ]  Responsive on mobile

---

## ✅ Phase 6: Git Integration (15 min)

### Step 12: Stage and Commit

```bash
# Check what changed
git status

# Add new files
git add .ai-context/
git add docs/branding/
git add docs/file-structure.md
git add assets/

# Add updated files
git add packages/shared-tokens/theme.css
git add packages/tailwind-preset/index.js
git add apps/blackjack/src/
git add apps/blackjack/index.html
git add README.md

# Commit with detailed message
git commit -m "Integrate GTTM brand system

Documentation:
- Add AI collaboration handoff documents
- Add brand guidelines and prompt library
- Add asset naming convention and workflow
- Add complete file structure documentation

Brand Assets:
- Add logo concepts (6 variations)
- Add icon library (30+ icons)
- Add social media templates
- Add interactive style guide

Code Updates:
- Update design tokens with semantic colors
- Update Tailwind preset with all brand colors
- Audit blackjack components for brand compliance
- Replace hardcoded colors with design tokens
- Add favicon and meta tags

Setup:
- Add .ai-context/ for AI collaboration
- Add assets/ directory structure
- Update root README with AI links"

```

- [ ]  All changes staged
- [ ]  Commit message written
- [ ]  Committed successfully

### Step 13: Push to Remote

```bash
# If you haven't set up remote yet:
git remote add origin https://github.com/yourusername/gttm-hub.git

# Push
git push -u origin main

# Or if already set up:
git push

```

- [ ]  Pushed to GitHub
- [ ]  Verify on GitHub web interface

---

## ✅ Phase 7: Prepare for AI Collaboration (10 min)

### Step 14: Create AI Session Templates

Create a file for easy copy-paste:

```bash
code .ai-context/session-start-template.md

```

**Content:**

```markdown
# Session Start Template

Copy this when starting work with Copilot, ChatGPT, or Claude:

---

Working on GTTM Hub: [TASK NAME]

**Project:** Get 'Em (GTTM Hub) - Learning-through-play platform
**Phase:** Brand integration and component development
**Repository:** https://github.com/[your-username]/gttm-hub

**Brand Identity:**
- Primary: #5A4BFF (Electric Indigo)
- Accent: #00E6A8 (Aqua Mint)
- Surface: #0F1117 (Void Black)
- Style: Flat minimalist, no shadows, high contrast

**Quick Links:**
- AI Quick Start: `.ai-context/ai-quickstart.md`
- Full Handoff: `.ai-context/ai-collaboration-handoff.md`
- Current Status: `.ai-context/current-project-state.md`
- File Structure: `docs/file-structure.md`

**Today's Task:**
[Describe what you're working on]

**Files Involved:**
- [List relevant files]

**Context Needed:**
[Any additional context]

---

```

- [ ]  Template created
- [ ]  Template tested (copy-paste works)

### Step 15: Update Current Project State

```bash
code .ai-context/current-project-state.md

```

**Add to "Recent Activity" section:**

```markdown
## Recent Activity 📅

### October 14, 2025 - Brand System Integration
- ✅ Created complete AI collaboration handoff system
- ✅ Integrated brand documentation into codebase
- ✅ Added logo concepts, icons, and templates
- ✅ Audited and updated design tokens
- ✅ Reviewed blackjack app for brand compliance
- ✅ Added favicons and meta tags
- ✅ Committed all changes to Git

**Next Session Goals:**
1. Create shared UI component library structure
2. Extract Button component from blackjack app
3. Extract Card component from blackjack app
4. Begin icon integration

```

- [ ]  Current state updated
- [ ]  Next goals documented

---

## 🎉 Completion Checklist

### Documentation ✅

- [ ]  All brand docs in `docs/branding/`
- [ ]  AI handoff docs in `.ai-context/`
- [ ]  File structure documented
- [ ]  README updated with AI links

### Assets ✅

- [ ]  Logos in `assets/source/svg/`
- [ ]  Icons in `assets/source/svg/`
- [ ]  Templates in `assets/source/html/`
- [ ]  Favicons ready for deployment

### Code ✅

- [ ]  Design tokens complete with semantic colors
- [ ]  Tailwind preset updated
- [ ]  Blackjack app audited
- [ ]  Hardcoded colors replaced
- [ ]  Favicon integrated

### Git ✅

- [ ]  All changes committed
- [ ]  Pushed to remote
- [ ]  Repository organized

### AI Collaboration ✅

- [ ]  Handoff document complete
- [ ]  Quick start guide ready
- [ ]  Session templates created
- [ ]  Current state updated

---

## 🚀 What's Next?

### Tomorrow (Phase 2)

1. **Create Shared UI Package**
    
    ```bash
    mkdir -p packages/shared-ui/src/components
    
    ```
    
2. **Extract First Components**
    - Button (from blackjack controls)
    - Card (UI card, not playing card)
    - Toast notifications
3. **Set up Component Development**
    - Add Storybook (optional)
    - Write component docs
    - Create usage examples

### This Week

- [ ]  Complete component library (10+ components)
- [ ]  Integrate icons throughout app
- [ ]  Create social media announcement posts
- [ ]  Generate blackjack card designs
- [ ]  Build marketing materials

### Next Week

- [ ]  Start presentation app
- [ ]  Add animations and transitions
- [ ]  Implement advanced game features
- [ ]  User testing and feedback

---

## 📝 Notes & Learnings

**What went well:**

- [Your notes here]

**What to improve:**

- [Your notes here]

**Questions for next session:**

- [Your questions here]

---

## 🆘 Troubleshooting

### If imports don't work:

```bash
# Reinstall dependencies
npm install

# Clear cache
rm -rf node_modules/.cache

```

### If tokens aren't applying:

```bash
# Check token import in each app
grep -r "@gttm-hub/shared-tokens" apps/

```

### If Git has conflicts:

```bash
# Stash changes
git stash

# Pull latest
git pull origin main

# Reapply changes
git stash pop

```

### If build fails:

```bash
# Check turbo cache
turbo run build --force

# Or rebuild from scratch
rm -rf node_modules
npm install
npm run build

```

---

## 🎯 Success Criteria

You've successfully completed Day 1 integration when:

✅ All brand documentation is in the repo

✅ AI collaboration files are set up

✅ Design tokens include all semantic colors

✅ Blackjack app uses tokens (no hardcoded colors)

✅ Favicon is integrated

✅ Everything is committed to Git

✅ You can start an AI session with context docs

✅ The app still works perfectly

---

## 📊 Time Tracking

**Estimated vs. Actual:**

| Phase | Estimated | Actual | Notes |
| --- | --- | --- | --- |
| Setup & Organization | 30 min | ___ min |  |
| Documentation | 20 min | ___ min |  |
| Token Audit | 30 min | ___ min |  |
| Code Audit | 45 min | ___ min |  |
| Asset Integration | 30 min | ___ min |  |
| Git Integration | 15 min | ___ min |  |
| AI Prep | 10 min | ___ min |  |
| **Total** | **3 hours** | **___ hours** |  |

---

## 🎨 Before & After

**Before:**

- Blackjack app with some hardcoded colors
- Basic design tokens
- No brand documentation
- No AI collaboration system

**After:**

- Complete brand system integrated
- All colors from design tokens
- Comprehensive documentation
- AI-ready collaboration setup
- Logos, icons, and templates
- Scalable architecture for growth

---

## 💬 Share Your Progress

When you're done, share with the team (or just document for yourself):

```markdown
✅ Day 1 Brand Integration Complete!

What we accomplished:
- 📚 Full brand documentation system
- 🤖 AI collaboration framework
- 🎨 Logo concepts, icons, templates
- 🔧 Token system with semantic colors
- ✨ Blackjack app brand compliance
- 📱 Favicon and meta tags

Stats:
- Files added: ~105
- Lines of documentation: ~2,000+
- Design tokens: 15+
- Assets created: 40+
- Time spent: X hours

Next: Building shared component library!

```

---

**Good luck! You've got this! 🚀**

**Questions during integration?**

- Check the handoff doc: `.ai-context/ai-collaboration-handoff.md`
- Review the quick start: `.ai-context/ai-quickstart.md`
- Look at file structure: `docs/file-structure.md`

**Need help from an AI?**

- Paste the session start template
- Reference specific files
- Ask specific questions

---

**Last Updated:** October 14, 2025

**Version:** 1.0

**Status:** Ready to Execute ✅