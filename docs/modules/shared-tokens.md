
# 📦 `shared-tokens` Module

## Overview

The `shared-tokens` package is the **source of truth** for design tokens across the monorepo. It uses [Style Dictionary](https://amzn.github.io/style-dictionary/#/) to compile `tokens.json` into two CSS outputs:

- `theme.css` → Tailwind v4-compatible `@theme` block  
- `vars.css` → legacy `:root` CSS variables for general use

These outputs are consumed by other packages like `tailwind-preset` and by individual apps.

---

## 🧬 Token Pipeline Diagram

```plaintext
tokens.json
   ↓
Style Dictionary
   ↓
├── theme.css → used by Tailwind v4 via @theme
└── vars.css  → used by vanilla CSS via :root
```

---

## 📁 File Structure

```
packages/shared-tokens/
├── tokens.json              # Source tokens
├── build-tokens-theme.js    # Builds theme.css
├── build-tokens-vars.js     # Builds vars.css
├── theme.css                # Tailwind v4 output
├── vars.css                 # Legacy CSS output
```

---

## 🛠 Build Instructions

From the root of the monorepo:

```bash
pnpm run build --filter shared-tokens
```

This runs both build scripts and outputs `theme.css` and `vars.css`.

---

## 🧩 How Other Packages Consume Tokens

### `tailwind-preset/config.css`
```css
@import "@gttm-hub/shared-tokens/theme.css";

@layer components {
  .btn {
    @apply px-md py-sm bg-primary text-white font-sans rounded-md;
  }
}
```

### Vanilla CSS App
```css
@import "@gttm-hub/shared-tokens/vars.css";

body {
  background-color: var(--color-background);
  font-family: var(--font-sans);
}
```

---

## 🧪 Test in an App

In `apps/blackjack/src/index.css`:

```css
@import "tailwindcss";
@source "@gttm-hub/tailwind-preset";
```

Then use:

```html
<div class="bg-primary p-md font-sans">
  Shared tokens in action!
</div>
```

---

## 🧠 Contributor Notes

- Tokens should only be edited in `tokens.json`  
- Run `pnpm run build --filter shared-tokens` after changes  
- Avoid manual edits to `theme.css` or `vars.css` — they’re auto-generated  
