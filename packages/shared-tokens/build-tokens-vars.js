// packages/shared-tokens/build-vars.js
import StyleDictionary from 'style-dictionary';
import { fileURLToPath } from 'url';
import path from 'path';
import fs from 'fs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const TOKENS_PATH = path.join(__dirname, 'tokens.json');

const config = {
  source: [TOKENS_PATH],
  platforms: {
    css: {
      transformGroup: 'css',
      buildPath: path.join(__dirname),
      files: [
        {
          destination: 'vars.css',
            format: 'css/variables',
        },
      ],
    },
  },
};

// Build
const sd = new StyleDictionary(config);
sd.buildAllPlatforms();

console.log('✅ CSS vars built → packages/shared-tokens/vars.css');
