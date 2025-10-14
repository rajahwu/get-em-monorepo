import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      '@gttm-hub/tailwind-preset': path.resolve(__dirname, '../../packages/tailwind-preset'),
      '@gttm-hub/shared-tokens': path.resolve(__dirname, '../../packages/shared-tokens'),
    }
  }
})
