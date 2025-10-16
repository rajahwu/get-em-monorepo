Previous Structure (Root-Level)
gttm-hub/
├── assets/
├── docs/branding/
├── .ai-context/
├── scripts/
└── [all other files]
New Structure (Package-Based)
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
Symlinks at Root (For DX)
assets/           → packages/brand-assets/assets
docs/branding/    → packages/brand-assets/docs/branding
.ai-context/      → packages/brand-assets/.ai-context
scripts/          → packages/brand-assets/scripts
Why this is better:

✅ Brand assets are a true workspace package (installable, versionable, publishable)
✅ Symlinks provide convenient root-level access
✅ Separates concerns: brand system is independent from code
✅ Can version brand assets independently (@gttm-hub/brand-assets@1.0.0)
✅ Scales better: other design systems can be added similarly