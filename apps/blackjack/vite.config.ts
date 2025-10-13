import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';
import path from 'path';

export default defineConfig({
  root: path.resolve(__dirname, 'src'),
  resolve: {
    alias: {
      '@gttm-hub/shared-tokens': path.resolve(__dirname, '../../packages/shared-tokens'),
      '@gttm-hub/shared-ui': path.resolve(__dirname, '../../packages/shared-ui/src'),
    },
  },
  plugins: [
    react(),
    tailwindcss(),
  ],
  server: {
    port: 5173,
    open: true,
  },
  css: {
    devSourcemap: true,
  },
});