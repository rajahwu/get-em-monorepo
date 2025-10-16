## 📘 **Tailwind Preset — Get ’Em (GTTM Hub)**

> Package: `@gttm-hub/tailwind-preset`
> Purpose: Provide a shared Tailwind CSS configuration and theme layer that all apps (`blackjack`, `presentation`, `systems`) can import directly.

---

### 🧭 Overview

This preset standardizes:

* Core **color, spacing, font, and motion tokens** (from `shared-tokens`)
* Shared **utility classes** and **component styles**
* **CSS variable** import pipeline for consistent theming

**Consumers:**
Each app imports it via `@source` in their `index.css`:

```css
@import "tailwindcss";
@source "@gttm-hub/tailwind-preset";
```

This ensures **one source of truth** for brand colors, typography, and layout primitives across the entire monorepo.

---

### 🧩 Directory Structure

```
packages/tailwind-preset/
├── config.css              # Main Tailwind layer imports + custom components
├── package.json            # Package definition
└── README.md               # This file
```

---

### 🎨 Integration with Shared Tokens

This preset automatically imports your token-generated `theme.css`:

```css
@import "@gttm-hub/shared-tokens/theme.css";
```

You can then reference tokens as variables inside component definitions, for example:

```css
@layer components {
  .btn {
    @apply px-md py-sm rounded-md font-semibold;
    background: var(--color-brand);
    color: var(--color-text);
  }

  .card {
    @apply p-md rounded-lg shadow-md;
    background: var(--color-surface);
    color: var(--color-text);
  }

  .badge {
    background: var(--color-accent);
    color: var(--color-textInverse);
    @apply px-sm py-xs rounded-sm text-sm;
  }
}
```

---

### ⚙️ Example Consumer Setup (Blackjack App)

**`apps/blackjack/src/index.css`:**

```css
@import "tailwindcss";
@source "@gttm-hub/tailwind-preset";
```

**`apps/blackjack/src/App.tsx`:**

```tsx
export default function App() {
  return (
    <div className="p-md">
      <h1 className="text-[--color-brand] font-bold text-3xl mb-md">
        Get ’Em Blackjack Trainer
      </h1>

      <div className="card">
        <p>Tokens, presets, and utilities all in sync 🎨</p>
      </div>

      <button className="btn mt-md">Hit Me</button>
    </div>
  );
}
```

---

### 🧱 Tailwind Configuration in Apps

Each consuming app (like `blackjack`) should have a minimal `tailwind.config.ts` that **extends** this preset:

```ts
import preset from "@gttm-hub/tailwind-preset/config.css";

export default {
  presets: [preset],
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
};
```

This keeps app configs tiny and ensures updates flow automatically from the preset.

---

### 🧪 Local Test Procedure

1. **Build shared tokens**

   ```bash
   pnpm run tokens-theme:build
   ```

2. **Run any app**

   ```bash
   pnpm run dev:blackjack
   ```

3. **Check expected visuals**

   * `.btn` background = `--color-brand`
   * `.card` background = `--color-surface`
   * No Tailwind variable resolution errors in console.

4. **Optional validation**

   ```bash
   pnpm list -r | grep tailwind-preset
   ```

   Confirms linked workspace visibility.

---

### 🧠 Troubleshooting

| Issue                          | Likely Cause                         | Fix                                                          |
| ------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
| CSS vars not applying          | Missing `@import` to `theme.css`     | Ensure preset imports `@gttm-hub/shared-tokens/theme.css`    |
| Tailwind classes not available | `@source` missing in consuming app   | Add `@source "@gttm-hub/tailwind-preset"` to app `index.css` |
| Styles don’t compile           | Version mismatch (Tailwind v3 vs v4) | Confirm all apps use Tailwind v4.1+                          |
| Tokens not regenerated         | Style Dictionary build not run       | Run `pnpm run tokens-theme:build`                            |

---

### 🧩 Example Tokens Reference (from `shared-tokens/theme.css`)

```css
@theme {
  --color-brand: #5A4BFF;
  --color-accent: #00E6A8;
  --color-surface: #0F1117;
  --color-text: #FFFFFF;
  --spacing-md: 16px;
  --radius-md: 8px;
  --motion-medium: 300ms;
}
```

---

### ✅ QA Checklist

| Checkpoint              | Pass Criteria                                    | Status |
| ----------------------- | ------------------------------------------------ | ------ |
| Tokens build            | Generates `theme.css`                            | ☐      |
| Preset imports          | Apps compile with no CSS errors                  | ☐      |
| Shared styles visible   | `.btn` + `.card` render correctly                | ☐      |
| Tailwind utility access | Arbitrary values resolve properly                | ☐      |
| Package linking         | `pnpm list -r` shows `@gttm-hub/tailwind-preset` | ☐      |
