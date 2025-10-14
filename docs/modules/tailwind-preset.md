# 🎨 `tailwind-preset` Module

## Overview

The `tailwind-preset` package provides a **shared Tailwind v4 theme layer** for all apps in the monorepo. It imports design tokens from `shared-tokens/theme.css` and exposes them via Tailwind’s `@theme` and `@layer` directives.

This enables consistent spacing, color, typography, and component styles across all apps — with zero duplication.

---

## 🧬 Preset Pipeline Diagram

```plaintext
shared-tokens/tokens.json
   ↓
Style Dictionary
   ↓
shared-tokens/theme.css
   ↓
tailwind-preset/config.css
   ↓
@source "@gttm-hub/tailwind-preset"
   ↓
apps/*/src/index.css
```

---

## 📁 File Structure

```
packages/tailwind-preset/
├── config.css         # Tailwind v4 theme + components
├── package.json       # Exports the preset
└── README.md          # Usage instructions
```

---

## 🧩 How It Works

### `config.css` includes:

```css
@import "@gttm-hub/shared-tokens/theme.css";

@layer components {
  .btn {
    @apply px-md py-sm bg-primary text-white font-sans rounded-md;
  }

  .card {
    @apply p-lg bg-background rounded-lg shadow-md;
  }
}
```

- `@import` pulls in token definitions from `shared-tokens`
- `@layer components` defines reusable utility classes

---

## 🧪 How Apps Consume It

### In `apps/blackjack/src/index.css`:

```css
@import "tailwindcss";
@source "@gttm-hub/tailwind-preset";
```

This gives the app access to:
- All token-based utilities (`bg-primary`, `p-md`, `font-sans`, etc.)
- All shared components (`.btn`, `.card`, etc.)

---

## 🧠 Contributor Notes

- Do **not** define tokens directly in `tailwind-preset` — they live in `shared-tokens/tokens.json`
- To add new utilities or components, edit `@layer components` in `config.css`
- To test new tokens, run:
  ```bash
  pnpm run build --filter shared-tokens
  ```

---

## 🧰 Example Usage

```html
<button class="btn">
  Click me
</button>

<div class="card text-text">
  Shared design system in action!
</div>
```