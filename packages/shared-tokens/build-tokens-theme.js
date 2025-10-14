// packages/shared-tokens/build-tokens.js
import StyleDictionary from 'style-dictionary';
import { fileURLToPath } from 'url';
import path from 'path';
import fs from 'fs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const TOKENS_PATH = path.join(__dirname, 'tokens.json');

// Helper: produce lines from a flat list of properties
function propsToLines(props) {
  return props.map((prop) => `  --${prop.path.join('-')}: ${prop.value};`);
}

// Helper: try several ways to extract properties
function resolveProperties(arg) {
  // 1) Newer API: arg is object { dictionary, file, options }
  if (arg && typeof arg === 'object' && arg.dictionary && Array.isArray(arg.dictionary.allProperties)) {
    return arg.dictionary.allProperties;
  }

  // 2) Older/positional API: arg itself may be the dictionary (array-like)
  if (arg && Array.isArray(arg.allProperties)) {
    return arg.allProperties;
  }

  // 3) Some runtimes expose 'properties' nested structure: flatten it
  if (arg && arg.properties && typeof arg.properties === 'object') {
    // Flatten nested properties into array of { path: [...], value }
    const out = [];
    function walk(node, prefix = []) {
      for (const key of Object.keys(node)) {
        const val = node[key];
        if (val && typeof val === 'object' && 'value' in val) {
          out.push({ path: [...prefix, key], value: val.value });
        } else if (val && typeof val === 'object') {
          walk(val, [...prefix, key]);
        }
      }
    }
    walk(arg.properties);
    return out;
  }

  // 4) Final fallback: read tokens.json directly and flatten it
  try {
    const raw = fs.readFileSync(TOKENS_PATH, 'utf8');
    const json = JSON.parse(raw);
    const out = [];
    function walkObj(node, prefix = []) {
      for (const k of Object.keys(node)) {
        const v = node[k];
        if (v && typeof v === 'object' && 'value' in v) {
          out.push({ path: [...prefix, k], value: v.value });
        } else if (v && typeof v === 'object') {
          walkObj(v, [...prefix, k]);
        }
      }
    }
    walkObj(json);
    return out;
  } catch (e) {
    return null;
  }
}

// Register a format compatible across Style Dictionary versions
StyleDictionary.registerFormat({
  name: 'tailwind-theme',
  // provide both keys for compatibility
  format: function (arg) {
    const props = resolveProperties(arg);
    if (!props || !props.length) return '/* no tokens */';
    const lines = propsToLines(props);
    return `@theme {\n${lines.join('\n')}\n}`;
  },
  formatter: function (arg) {
    const props = resolveProperties(arg);
    if (!props || !props.length) return '/* no tokens */';
    const lines = propsToLines(props);
    return `@theme {\n${lines.join('\n')}\n}`;
  },
});

const config = {
  source: [path.join(__dirname, 'tokens.json')],
  platforms: {
    css: {
      transformGroup: 'css',
      buildPath: path.join(__dirname),
      files: [
        {
          destination: 'theme.css',
          format: 'tailwind-theme',
        },
      ],
    },
  },
};

// Use the constructor form that works in your environment
const sd = new StyleDictionary(config);
sd.buildAllPlatforms();

console.log('✅ Tokens built → packages/shared-tokens/theme.css');