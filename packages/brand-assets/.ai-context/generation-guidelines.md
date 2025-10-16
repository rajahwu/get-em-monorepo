# AI Generation Guidelines for GTTM Assets

## Brand Identity

**Project:** Get 'Em (GTTM Hub)  
**Tagline:** Train Smarter. Play Harder.  
**Personality:** Playful Precision • Systems Thinking • Technical Elegance • Empowering

## Color Palette (Always Use These)

```
Primary Brand:    #5A4BFF (Electric Indigo)
Accent:           #00E6A8 (Aqua Mint)
Surface:          #0F1117 (Void Black)
Surface Alt:      #161A22 (Deep Slate)
Border:           #2A2E37 (Charcoal)
Text:             #FFFFFF (White)
Text Muted:       #A0AEC0 (Muted Silver)
Peach:            #FFCAB1 (Peach Glow)
Crimson:          #E05263 (Crimson Rose)
```

## Design Style: Flat Minimalism

### Always Include
- Flat design (NO shadows, NO gradients except brand gradient)
- High contrast for accessibility
- Clean lines and geometric shapes
- Ample whitespace
- Clear visual hierarchy

### Never Include
- ❌ 3D effects or depth
- ❌ Texture overlays
- ❌ Drop shadows
- ❌ Gradients (except primary #5A4BFF → #00E6A8)
- ❌ Skeuomorphic elements

## Naming Convention (Critical)

**Pattern:** `gttm-[category]-[descriptor]-[variant]-[size].[ext]`

**Examples:**
- `gttm-logo-wordmark-primary.svg`
- `gttm-icon-play-primary-24.svg`
- `gttm-social-instagram-post-launch-20251014.png`
- `gttm-game-blackjack-card-spade.svg`

**Categories:** logo, icon, social, game, bg, marketing, screenshot, mockup

## When Generating SVG

```xml
<!-- Include these -->
<svg viewBox="0 0 [width] [height]" xmlns="http://www.w3.org/2000/svg">
  <title>[Asset Name]</title>
  <desc>[Purpose and usage]</desc>
  <!-- Content -->
</svg>
```

**Rules:**
- Use viewBox (not width/height)
- Include semantic title and desc
- Optimize paths (no unnecessary points)
- Use hex colors directly (no named colors)
- Keep file size minimal

## When Creating HTML/Templates

**Must include:**
- Inline styles (for portability)
- CSS custom properties for colors
- Responsive design (mobile-first)
- High contrast text
- Semantic HTML5

**Example structure:**
```html
<style>
  :root {
    --color-brand: #5A4BFF;
    --color-accent: #00E6A8;
    --color-surface: #0F1117;
  }
  /* Flat, minimal styles */
</style>
```

## Quality Checklist

Before delivering ANY asset:
- [ ] Uses exact brand colors (hex codes)
- [ ] Follows flat minimalist style
- [ ] Named according to convention
- [ ] Optimized file size
- [ ] Includes title/description
- [ ] High contrast (WCAG AA minimum)
- [ ] Works on dark backgrounds

## Tool-Specific Instructions

### For Midjourney Prompts
Always add:
- `--style raw --v 6`
- `--no shadows gradients 3d depth texture`
- Include hex codes: "using colors #5A4BFF and #00E6A8"

### For DALL·E Prompts
- Explicitly state "flat design, no shadows, minimalist"
- Specify "high contrast, simple geometric shapes"
- Include "dark background #0F1117" if relevant

### For Claude (SVG/HTML)
- Generate complete, working code
- Use semantic naming
- Include comments for complex parts
- Make easily modifiable

## Iteration Protocol

1. Generate initial version
2. Wait for feedback
3. Create new version with suffix: `-v2`, `-v3`
4. Keep previous versions in `assets/source/archive/`
5. Document changes in commit message

## Documentation Requirements

After generating each asset:
1. Save prompt used to `assets/source/prompts-used/[asset-name].txt`
2. Update `asset-inventory.md`
3. Note any variations or iterations
4. Document intended usage

## Common Mistakes to Avoid

❌ Using wrong colors  
❌ Adding shadows or 3D effects  
❌ Incorrect naming convention  
❌ Missing title/desc in SVG  
❌ Not optimizing file size  
❌ Forgetting to update inventory  

## When Uncertain

- Refer to `docs/branding/brand-guidelines.md`
- Check existing assets for patterns
- Ask for clarification before generating
- Suggest alternatives if request conflicts with brand

---

**Remember:** Consistency is key. When in doubt, simpler is better.
