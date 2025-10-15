# 🎮 Get 'Em Monorepo

A modular workspace for building token-driven design systems, interactive training apps, and scalable UI pipelines — powered by Tailwind v4, shared tokens, and contributor-first workflows.

---

## 🚀 Quick Start

```bash
pnpm install
pnpm -r --filter shared-tokens run build
pnpm -r --filter blackjack run dev
```

Then open [http://localhost:5173](http://localhost:5173) to view the Blackjack demo.

---

## 🧱 Monorepo Structure

| Folder                  | Purpose                                                  |
|------------------------|----------------------------------------------------------|
| `apps/blackjack`       | Vite + React demo app using shared design system         |
| `packages/shared-tokens` | Source of design tokens + build scripts for theme/vars CSS |
| `packages/tailwind-preset` | Tailwind v4 preset consuming tokens + exposing components |
| `docs/`                | Optional documentation site or guides                    |
| `scripts/`             | Build and utility scripts                                |

---

## 🎨 Design Token Pipeline

1. Tokens are defined in `packages/shared-tokens/tokens.json`
2. Build scripts output:
   - `theme.css` → used by Tailwind via `@theme { ... }`
   - `vars.css` → used by runtime CSS via `:root { ... }`
3. `packages/tailwind-preset/config.css` imports `theme.css` and defines component classes
4. Apps (like Blackjack) import Tailwind and use `@source "@gttm-hub/tailwind-preset"` in `index.css`

---

## 🧪 Developer Checklist

- ✅ `pnpm install` — installs all workspace packages
- ✅ `pnpm -r --filter shared-tokens run build` — builds token outputs
- ✅ `pnpm -r --filter blackjack run dev` — starts the demo app
- ✅ `pnpm -w exec tsc --noEmit` — verifies type safety across workspace

---

## 🛠️ Troubleshooting

- **Missing tokens in app?**
  - Ensure `index.css` includes `@source "@gttm-hub/tailwind-preset"`
  - Confirm `main.tsx` imports `./index.css`
  - Rebuild tokens: `pnpm run build --filter shared-tokens`

- **pnpm workspace errors?**
  - Move backup folders outside `apps/*` or exclude them in `pnpm-workspace.yaml`

- **TypeScript error: `react/jsx-runtime` missing?**
  ```bash
  pnpm add react react-dom
  pnpm add -D @types/react @types/react-dom
  ```

---

## 🤝 Contributing

- Branch from `main` or `feat/*`
- Use conventional commits (`fix:`, `chore:`, `feat:`)
- Run all verification steps before opening a PR
- Include screenshots or token grid if relevant

---

## 📸 Demo Preview

![Blackjack demo screenshot](docs/assets/blackjack-preview.png)  
_Shared tokens in action: brand colors, spacing, and typography from the design system._

---

## 📚 Docs & Teaching

This repo powers the **VSMForge** teaching platform — enabling creators to master systems thinking through modular, documented workflows. Coming soon: visual token grid, contributor onboarding guide, and live demo links.

---

## 🧠 Credits

Built by [@rajahwu](https://github.com/rajahwu) and [@vmrad](https://github.com/vmrad)  
Powered by Tailwind v4, pnpm workspaces, and relentless iteration.

