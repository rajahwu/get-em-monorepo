# GTTM Hub - Asset Naming Convention

> Purpose: Standardized naming system for all brand assets to ensure consistency, discoverability, and version control.
> 

> Last Updated: 2025-10-14
> 
> 
> **Version:** 1.0
> 

---

## 📋 General Naming Pattern

```
gttm-[category]-[descriptor]-[variant]-[size].[extension]

```

### Pattern Breakdown

- **gttm**: Project prefix (always lowercase)
- **category**: Asset type (logo, icon, social, etc.)
- **descriptor**: Specific name or purpose
- **variant**: Color scheme, style, or state
- **size**: Dimensions (optional for vectors)
- **extension**: File format

---

## 🎨 Logo Assets

### Pattern

```
gttm-logo-[type]-[variant]-[size].[ext]

```

### Examples

```
gttm-logo-wordmark-primary.svg
gttm-logo-wordmark-white.svg
gttm-logo-wordmark-dark.png
gttm-logo-icon-gradient-512.png
gttm-logo-icon-flat-256.png
gttm-logo-badge-outline.svg
gttm-logo-full-tagline.svg
gttm-logo-mark-monochrome.svg

```

### Logo Types

- `wordmark`: Text-only logo (GTTM)
- `icon`: Symbol/mark only
- `badge`: Logo with border/frame
- `full`: Complete logo with tagline
- `mark`: Simplified brand mark

### Logo Variants

- `primary`: Main brand color (#5A4BFF)
- `gradient`: Indigo to mint gradient
- `white`: White/light backgrounds
- `dark`: Dark/black backgrounds
- `monochrome`: Single color
- `outline`: Line-only version

---

## 🖼️ Favicon & App Icons

### Pattern

```
gttm-favicon-[size].[ext]
gttm-app-icon-[platform]-[size].[ext]

```

### Examples

```
gttm-favicon-16.png
gttm-favicon-32.png
gttm-favicon-64.ico
gttm-app-icon-apple-180.png
gttm-app-icon-android-192.png
gttm-app-icon-android-512.png
gttm-app-icon-windows-150.png
gttm-app-icon-pwa-512.png

```

### Platform Specifications

- `apple`: iOS/macOS (180x180, 1024x1024)
- `android`: Android (192x192, 512x512)
- `windows`: Windows tiles (150x150, 310x310)
- `pwa`: Progressive Web App (192x192, 512x512)

---

## 🎯 UI Icons

### Pattern

```
gttm-icon-[name]-[variant]-[size].[ext]

```

### Examples

```
gttm-icon-play-primary-24.svg
gttm-icon-pause-primary-24.svg
gttm-icon-settings-outline-32.svg
gttm-icon-user-filled-24.svg
gttm-icon-success-circle-32.svg
gttm-icon-error-circle-32.svg
gttm-icon-warning-circle-32.svg
gttm-icon-info-circle-32.svg

```

### Icon Variants

- `filled`: Solid fill
- `outline`: Line/stroke only
- `circle`: Circular background
- `primary`: Brand color
- `accent`: Mint color
- `muted`: Gray/neutral

### Standard Sizes

- `16`: Extra small
- `24`: Default UI size
- `32`: Large UI elements
- `48`: Extra large
- `64`: Hero icons

---

## 🎴 Game Assets

### Pattern

```
gttm-game-[game]-[asset]-[variant].[ext]

```

### Examples

```
gttm-game-blackjack-card-back.svg
gttm-game-blackjack-card-spade.svg
gttm-game-blackjack-card-heart.svg
gttm-game-blackjack-card-diamond.svg
gttm-game-blackjack-card-club.svg
gttm-game-blackjack-chip-blue.svg
gttm-game-blackjack-chip-red.svg
gttm-game-blackjack-table-bg.png
gttm-game-blackjack-dealer-area.svg

```

---

## 📱 Social Media Assets

### Pattern

```
gttm-social-[platform]-[type]-[descriptor]-[date].[ext]

```

### Examples

```
gttm-social-instagram-post-launch-20251014.png
gttm-social-instagram-story-feature-20251014.png
gttm-social-twitter-card-announcement.png
gttm-social-linkedin-banner-primary.png
gttm-social-youtube-thumbnail-tutorial.png
gttm-social-facebook-cover-main.png

```

### Platform Sizes

```
Instagram Post:        1080x1080  (gttm-social-instagram-post-*.png)
Instagram Story:       1080x1920  (gttm-social-instagram-story-*.png)
Twitter/X Card:        1200x628   (gttm-social-twitter-card-*.png)
LinkedIn Banner:       1584x396   (gttm-social-linkedin-banner-*.png)
YouTube Thumbnail:     1280x720   (gttm-social-youtube-thumb-*.png)
Facebook Cover:        820x312    (gttm-social-facebook-cover-*.png)

```

---

## 🎨 Background Patterns & Textures

### Pattern

```
gttm-bg-[type]-[variant].[ext]

```

### Examples

```
gttm-bg-grid-primary.svg
gttm-bg-gradient-hero.png
gttm-bg-pattern-subtle.svg
gttm-bg-noise-dark.png
gttm-bg-geometric-light.svg

```

---

## 📊 Marketing Materials

### Pattern

```
gttm-marketing-[type]-[descriptor]-[version].[ext]

```

### Examples

```
gttm-marketing-banner-web-v1.png
gttm-marketing-poster-launch-v2.pdf
gttm-marketing-flyer-event-print.pdf
gttm-marketing-slide-deck-pitch.pdf
gttm-marketing-one-pager-overview.pdf

```

---

## 🖼️ Screenshots & Mockups

### Pattern

```
gttm-screenshot-[app]-[view]-[date].[ext]
gttm-mockup-[device]-[view].[ext]

```

### Examples

```
gttm-screenshot-blackjack-gameplay-20251014.png
gttm-screenshot-landing-hero-20251014.png
gttm-mockup-mobile-login.png
gttm-mockup-desktop-dashboard.png
gttm-mockup-tablet-game.png

```

---

## 📄 File Format Guidelines

### Vector Graphics (Preferred)

- **SVG**: Logos, icons, illustrations
    - Use for web (inline or linked)
    - Scalable without quality loss
    - Small file size

### Raster Graphics

- **PNG**: Transparent backgrounds, UI elements
    - Use 24-bit with alpha channel
    - 2x resolution for retina displays
- **JPG**: Photos, complex images without transparency
    - 80-90% quality for web
    - 100% quality for print
- **WEBP**: Modern web format
    - Better compression than PNG/JPG
    - Use for web when possible

### Special Formats

- **ICO**: Windows favicons (multi-size)
- **PDF**: Print materials, presentations
- **GIF**: Simple animations (use sparingly)

---

## 🎯 Resolution Standards

### Web Assets

```
1x:   Base resolution (e.g., 24x24px)
2x:   Retina displays (e.g., 48x48px)
3x:   High-DPI displays (e.g., 72x72px)

```

### Naming Convention for Multi-Resolution

```
gttm-icon-play-primary-24.svg       (vector, any resolution)
gttm-icon-play-primary-24@1x.png    (24x24px)
gttm-icon-play-primary-24@2x.png    (48x48px)
gttm-icon-play-primary-24@3x.png    (72x72px)

```

### Print Assets

- **Screen**: 72 DPI
- **Print**: 300 DPI minimum
- **Large Format**: 150 DPI acceptable

---

## 📁 Directory Structure

```
assets/
├── brand/
│   ├── logos/
│   │   ├── gttm-logo-wordmark-primary.svg
│   │   ├── gttm-logo-icon-gradient-512.png
│   │   └── gttm-logo-full-tagline.svg
│   ├── favicons/
│   │   ├── gttm-favicon-16.png
│   │   ├── gttm-favicon-32.png
│   │   └── gttm-app-icon-apple-180.png
│   └── patterns/
│       ├── gttm-bg-grid-primary.svg
│       └── gttm-bg-gradient-hero.png
├── ui/
│   ├── icons/
│   │   ├── gttm-icon-play-primary-24.svg
│   │   ├── gttm-icon-pause-primary-24.svg
│   │   └── gttm-icon-settings-outline-32.svg
│   └── components/
│       ├── gttm-button-primary.svg
│       └── gttm-card-default.svg
├── game/
│   ├── blackjack/
│   │   ├── gttm-game-blackjack-card-back.svg
│   │   ├── gttm-game-blackjack-card-spade.svg
│   │   └── gttm-game-blackjack-table-bg.png
│   └── [other-games]/
├── social/
│   ├── instagram/
│   │   ├── gttm-social-instagram-post-launch-20251014.png
│   │   └── gttm-social-instagram-story-feature-20251014.png
│   ├── twitter/
│   │   └── gttm-social-twitter-card-announcement.png
│   └── [other-platforms]/
├── marketing/
│   ├── gttm-marketing-banner-web-v1.png
│   └── gttm-marketing-slide-deck-pitch.pdf
└── screenshots/
    ├── gttm-screenshot-blackjack-gameplay-20251014.png
    └── gttm-mockup-mobile-login.png

```

---

## ✅ Best Practices

### Do's

- ✅ Use lowercase for all filenames
- ✅ Use hyphens (-) to separate words
- ✅ Include size dimensions in filename
- ✅ Use descriptive names
- ✅ Version files when iterating (v1, v2, etc.)
- ✅ Include date for time-sensitive assets (YYYYMMDD)
- ✅ Keep names under 50 characters when possible

### Don'ts

- ❌ Don't use spaces in filenames
- ❌ Don't use special characters (!, @, #, $, etc.)
- ❌ Don't use underscores (use hyphens instead)
- ❌ Don't use vague names (image1.png, final-final.svg)
- ❌ Don't include personal names
- ❌ Don't use UPPERCASE or CamelCase

---

## 🔄 Version Control

### Semantic Versioning for Assets

```
gttm-logo-wordmark-v1.0.svg    (Major version)
gttm-logo-wordmark-v1.1.svg    (Minor update)
gttm-logo-wordmark-v2.0.svg    (Major redesign)

```

### Date-based Versioning

```
gttm-social-instagram-post-20251014.png    (Oct 14, 2025)
gttm-social-instagram-post-20251115.png    (Nov 15, 2025)

```

---

## 📝 Metadata Standards

### SVG Files

Include metadata in SVG files:

```xml
<title>GTTM Logo Wordmark Primary</title>
<desc>Primary wordmark logo for Get 'Em (GTTM Hub) in brand indigo color</desc>

```

### PNG/JPG Files

Use EXIF/XMP metadata:

- **Title**: Asset name
- **Description**: Purpose and usage
- **Copyright**: © 2025 GTTM Hub
- **Keywords**: gttm, logo, brand, gaming, etc.

---

## 🔍 Quick Reference Chart

| Asset Type | Pattern | Example |
| --- | --- | --- |
| Logo | `gttm-logo-[type]-[variant]` | `gttm-logo-wordmark-primary.svg` |
| Icon | `gttm-icon-[name]-[variant]-[size]` | `gttm-icon-play-primary-24.svg` |
| Favicon | `gttm-favicon-[size]` | `gttm-favicon-32.png` |
| Social | `gttm-social-[platform]-[type]-[desc]` | `gttm-social-instagram-post-launch.png` |
| Game | `gttm-game-[game]-[asset]-[variant]` | `gttm-game-blackjack-card-spade.svg` |
| Background | `gttm-bg-[type]-[variant]` | `gttm-bg-grid-primary.svg` |
| Screenshot | `gttm-screenshot-[app]-[view]-[date]` | `gttm-screenshot-blackjack-20251014.png` |

---

## 🤝 Contributing

When adding new assets:

1. Follow the naming convention
2. Place in appropriate directory
3. Include source files (.ai, .fig, .sketch) when applicable
4. Update `assets/README.md` with new asset types
5. Export at required resolutions
6. Optimize file sizes before committing

---

**Questions or suggestions?** Open an issue or PR with the tag `asset-naming`.