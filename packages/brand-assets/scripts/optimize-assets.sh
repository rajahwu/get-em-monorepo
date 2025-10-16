#!/bin/bash

# Optimize Assets
# Batch optimize PNG and JPG files

echo "Optimizing assets..."

# Check if optimization tools are installed
if ! command -v optipng &> /dev/null && ! command -v pngquant &> /dev/null; then
    echo "Warning: No PNG optimization tools found."
    echo "Install with: brew install optipng pngquant"
fi

if ! command -v jpegoptim &> /dev/null; then
    echo "Warning: jpegoptim not found."
    echo "Install with: brew install jpegoptim"
fi

# Optimize PNGs
if command -v pngquant &> /dev/null; then
    echo "Optimizing PNGs with pngquant..."
    find assets/finalized -name "*.png" -exec pngquant --quality=80-95 --ext .png --force {} \;
fi

# Optimize JPGs
if command -v jpegoptim &> /dev/null; then
    echo "Optimizing JPGs with jpegoptim..."
    find assets/finalized -name "*.jpg" -exec jpegoptim --max=85 {} \;
fi

echo "✓ Optimization complete"
