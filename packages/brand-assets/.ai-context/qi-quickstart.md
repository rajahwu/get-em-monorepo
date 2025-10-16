GTTM Hub - AI Quick Start Context
Copy-paste this into Copilot, ChatGPT, or Claude when starting work

🎮 Project: Get 'Em (GTTM Hub)
Tagline: Train Smarter. Play Harder.
Type: Learning-through-play platform (gaming + training)
Status: Active development, integrating brand system with existing codebase

🎨 Brand Identity (GTTM-01)
css
/* Use ONLY these colors (already in packages/shared-tokens/theme.css) */
--color-brand: #5A4BFF;      /* Electric Indigo - primary actions */
--color-accent: #00E6A8;     /* Aqua Mint - success, highlights */
--color-surface: #0F1117;    /* Void Black - main background */
--color-text: #FFFFFF;       /* White - primary text */
--color-text-muted: #A0AEC0; /* Muted Silver - secondary text */
--color-warning: #FFCAB1;    /* Peach Glow - warnings */
--color-error: #E05263;      /* Crimson Rose - errors */
Design Style:

✅ Flat minimalist (NO shadows, NO gradients except brand gradient)
✅ High contrast, dark-first
✅ Clean geometric shapes
✅ Accessible (WCAG AA minimum)
🏗️ Codebase Structure
gttm-hub/                    # Monorepo (turborepo)
├── apps/
│   └── blackjack/          # ✅ COMPLETE (React + Vite + Tailwind)
├── packages/
│   ├── shared-tokens/      # ✅ Design tokens (CSS vars)
│   ├── tailwind-preset/    # ✅ Tailwind config
│   └── shared-ui/          # 🔄 IN PROGRESS (component library)
├── docs/branding/          # ✅ Brand guidelines & prompts
└── assets/                 # ✅ Logos, icons, templates
Tech Stack:

Monorepo: Turborepo
Frontend: React 18 + Vite
Styling: Tailwind CSS + CSS Custom Properties
Language: JavaScript (TypeScript consideration)
🎯 Current Mission
Integrating brand system with existing codebase:

Audit tokens → Ensure all GTTM-01 colors in packages/shared-tokens/theme.css
Update components → Replace hardcoded colors with tokens
Extract to shared-ui → Move reusable components to packages/shared-ui/
Integrate assets → Add logos, favicons, icons to apps
Document everything → Keep docs up to date
🤖 Quick Rules for AI Collaboration
✅ ALWAYS
Use design tokens (no hardcoded colors)
Follow flat minimalist style (no shadows)
Name files: gttm-[category]-[descriptor]-[variant].[ext]
Update documentation when changing code
Check .ai-context/current-project-state.md for latest status
❌ NEVER
Hardcode colors (use var(--color-brand) etc.)
Add shadows, 3D effects, or non-brand gradients
Ignore accessibility (maintain high contrast)
Skip updating .ai-context/current-project-state.md
📋 Example Tasks for AIs
For Copilot (In-Editor)
javascript
// Create a Button component using design tokens
// Variants: primary (brand), secondary (accent), outline
// Sizes: sm, md, lg
// Must be accessible with proper ARIA labels
For ChatGPT (Problem Solving)
markdown
Reviewing blackjack app code for brand compliance.

Check if components use:
1. Design tokens (not hardcoded colors)
2. Flat design (no shadows)
3. Proper accessibility
4. Semantic HTML

Files: apps/blackjack/src/components/*.jsx
For Claude (Asset/Component Generation)
markdown
Create a Toast notification component for GTTM Hub.

Requirements:
- Use design tokens from packages/shared-tokens/theme.css
- Variants: info (brand), success (accent), warning (peach), error (crimson)
- Flat design, no shadows
- Export-ready for packages/shared-ui/
- Accessible with ARIA live regions
📚 Key Files Reference
For code work:

Design tokens: packages/shared-tokens/theme.css
Tailwind config: packages/tailwind-preset/index.js
Example app: apps/blackjack/src/
For brand work:

Guidelines: docs/branding/brand-guidelines.md
AI prompts: docs/branding/prompts.md
Naming: docs/branding/asset-naming-convention.md
For context:

Project status: .ai-context/current-project-state.md
Generation rules: .ai-context/generation-guidelines.md
Full handoff: .ai-context/ai-collaboration-handoff.md
🎨 Quick Component Pattern
jsx
// Example: Button component using design tokens
import './theme.css'; // Import tokens

export function Button({ 
  variant = 'primary',  // primary | secondary | outline
  size = 'md',         // sm | md | lg
  children,
  ...props 
}) {
  const baseClasses = 'font-medium transition-colors';
  
  const variantClasses = {
    primary: 'bg-[var(--color-brand)] text-white hover:opacity-90',
    secondary: 'bg-[var(--color-accent)] text-[var(--color-surface)] hover:opacity-90',
    outline: 'border border-[var(--color-border)] text-[var(--color-text)] hover:border-[var(--color-accent)]'
  };
  
  const sizeClasses = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2 text-base',
    lg: 'px-6 py-3 text-lg'
  };
  
  return (
    <button 
      className={`${baseClasses} ${variantClasses[variant]} ${sizeClasses[size]}`}
      {...props}
    >
      {children}
    </button>
  );
}
🚀 Current Sprint Tasks
Priority 1 (This Week):

 Audit all components for hardcoded colors
 Replace with design token references
 Create shared Button component
 Create shared Card component
 Integrate favicon and logo into blackjack app
 Extract reusable components to packages/shared-ui/
Priority 2 (Next Week):

 Complete shared-ui component library (10+ components)
 Add icon system (SVG icon wrapper)
 Create Toast notification system
 Build Loading spinner component
 Update all documentation
💬 Session Start Template
markdown
Working on GTTM Hub: [Your task name]

Current focus: [Specific component/feature]
Files: [List relevant files]
Goal: [What you want to accomplish]

Context needed:
- Brand colors: packages/shared-tokens/theme.css
- Current code: [paste if needed]
- Guidelines: docs/branding/brand-guidelines.md

Question/Task: [Be specific]
✅ Before Submitting Code
Check:

 Uses design tokens (no hardcoded #hex colors)
 Flat design (no shadows, no non-brand gradients)
 High contrast (WCAG AA minimum)
 Semantic HTML with proper ARIA
 Named correctly (if asset: gttm-[category]-[name])
 Documentation updated
 Follows existing patterns
Full details: .ai-context/ai-collaboration-handoff.md
Last updated: October 14, 2025

