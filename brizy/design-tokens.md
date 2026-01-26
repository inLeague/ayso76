# AYSO Region 76 - Design Tokens for Brizy Conversion

## Color Palette

### Primary Colors
- **Primary Orange (Brand Color)**: `#ef832f`
  - Used for: Headings (h1, h2, h3), buttons, links, hover states
  - Hover/Light variant: `#fcc04d` (light orange)

### Secondary Colors
- **Teal/Blue-Green**: `#206B70`
  - Used for: Dropdown menu sub-headers
- **Brown/Orange Accent**: `#D69048`
  - Used for: Footer background, info banner, dropdown menu links, navbar border

### Background Colors
- **White/Off-White**: `#ffffff` / `#fefefe`
  - Used for: Main page background, card backgrounds
- **Light Grey**: `#f2f5f6`
  - Used for: Internal banner gradient base
- **Light Grey Alt**: `#f0f3f5`
  - Used for: Grey call-out boxes
- **Table Row Even**: `#f2efef`
  - Used for: Alternating table rows
- **Dark Grey**: `#2d2f30`
  - Used for: Table headers, above-footer section, dropdown borders

### Text Colors
- **Primary Text (Dark)**: `#1b2b34`
  - Used for: Body text, paragraphs
- **Black/Heading**: `#06121b`
  - Used for: Body color, navigation links
- **White Text**: `#fefefe`
  - Used for: Text on colored backgrounds
- **Muted Text**: `#5b5e5f`
  - Used for: Small text variants

### Note on "Primary Blue" and "Secondary Red"
The site primarily uses **orange** (`#ef832f`) as the main brand color rather than blue. The teal color `#206B70` appears in dropdown headers. There is no red color used as a secondary color in the current design system. The orange serves as both primary brand color and accent/CTA color.

---

## Typography

### Font Families
- **Heading Font**: `'Fjalla One'` (sans-serif)
  - Used for: H1, H4, H5, H6, navigation, buttons
- **Body Font**: `'Noto Sans'`
  - Used for: Body text, paragraphs, H2, H3

### Base Typography
- **Base Font Size**: `16px` (1rem)
- **Base Line Height**: `2rem` (32px)

### Heading Sizes
- **H1**: 
  - Font size: `2.425em` (≈ 38.8px at 16px base)
  - Line height: `3.750rem` (60px)
  - Color: `#ef832f`
  - Text transform: uppercase
  - Letter spacing: `0.025em`
  
- **H2**: 
  - Font size: `1.3875em` (≈ 22.2px)
  - Line height: `1.3875rem` (≈ 22.2px)
  - Color: `#ef832f`
  - Text transform: uppercase
  - Letter spacing: `0.025em`
  - Font weight: `600`
  
- **H3**: 
  - Font size: `0.938em` (≈ 15px)
  - Line height: `2rem` (32px)
  - Color: `#ef832f` (via `$lorange` variable: `#fcc04d`)
  - Text transform: uppercase
  - Letter spacing: `0.105em`

### Body Text
- **Paragraph Line Height**: `2rem` (32px)
- **Paragraph Letter Spacing**: `0.015em`
- **Small Text**: 
  - Font size: `0.938em` (≈ 15px)
  - Line height: `1.375rem` (≈ 22px)
  - Letter spacing: `0.025em`
  - Color: `#5b5e5f`

---

## Container Width

### Main Content Container
- **Max Width**: `1140px` (Bootstrap default `.container` class)
  - Note: Bootstrap's default container max-widths:
    - Small (≥576px): 540px
    - Medium (≥768px): 720px
    - Large (≥992px): 960px
    - Extra Large (≥1200px): 1140px
- **Alternative Reference**: A commented-out container in `home.cfm` shows `max-width: 1600px`, but this is not currently active.

---

## Buttons

### Button Styling
- **Border Radius**: `6px`
- **Font Family**: `'Fjalla One'` (heading font)
- **Font Size**: `0.875em` (≈ 14px)
- **Text Transform**: uppercase
- **Text Align**: center

### Button Padding
- **Standard Button**: No explicit padding defined in base `.btn` class
- **Orange Button (`.orange-btn`)**: 
  - Background: `#ef832f`
  - Color: `#fefefe`
  - Hover background: `#fcc04d`
- **Grey Call-out Button**: 
  - Padding: `8px 1px`
  - Max width: `302px`
  - Letter spacing: `0.1em`
- **Search Button**: 
  - Padding: `5px 12px`
  - Min height: `32px`
  - Border radius: `4px`

### Recommended Button Padding for Brizy
Based on the search button and grey call-out button patterns:
- **Horizontal Padding**: `12px` to `15px`
- **Vertical Padding**: `8px` to `10px`
- **Minimum Height**: `32px`

---

## Additional Design Elements

### Shadows
- **Card/Box Shadow**: `0 5px 8px rgba(0, 0, 0, 0.12)` (used on internal template nav)

### Borders
- **Navbar Border**: `12px double #D69048` (bottom border)
- **Dropdown Border**: `3px solid #2d2f30` (top border)

### Gradients
- **Internal Banner Gradient**: 
  - `linear-gradient(45deg, #e3a225 0%, #f18f01 100%)`
  - Fallback: `#f2f5f6`

---

## Summary for Brizy Input

### Colors
- Primary: `#ef832f` (Orange - main brand color)
- Secondary: `#206B70` (Teal - used in dropdowns) OR `#D69048` (Brown/Orange - footer/accent)
- Background: `#ffffff` / `#fefefe`
- Text Body: `#1b2b34`
- Text Heading: `#06121b` or `#ef832f` (depending on context)

### Typography
- Heading Font: `Fjalla One`
- Body Font: `Noto Sans`
- Base Size: `16px`
- H1: `38.8px` (2.425em)
- H2: `22.2px` (1.3875em)
- H3: `15px` (0.938em)
- Line Height: `32px` (2rem) for body

### Container
- Max Width: `1140px` (Bootstrap standard)

### Buttons
- Border Radius: `6px`
- Padding: `8px 12px` (recommended)
- Min Height: `32px`
