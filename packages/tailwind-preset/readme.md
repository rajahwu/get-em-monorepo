# @get-em/tailwind-preset

Shared Tailwind preset for the Get ’Em monorepo.

## Usage
In your app’s `tailwind.config.js`:

```js
import preset from '@get-em/tailwind-preset';

export default {
  presets: [preset],
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
};

