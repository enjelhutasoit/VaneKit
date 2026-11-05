# ADR-0002: Token design

## Context
Components need a stable styling vocabulary that is accessible by construction.

## Decision
- Colors are semantic roles resolved per `ColorScheme`; palettes are plain
  8-bit sRGB values in code (no asset catalog, no bundle resources).
- WCAG 2.x contrast is computed in code and enforced by tests: 4.5:1 for text
  pairs, 3:1 for accent/critical against backgrounds.
- Typography maps to system text styles; no fixed point sizes, so Dynamic Type applies.
- Spacing uses a 4-point grid; radius has three steps.

## Alternatives
- Asset catalog colors: automatic appearance switching, but needs bundle
  resources and is harder to test.
- Fixed font sizes: rejected, breaks Dynamic Type.

## Consequences
- Consumers pass the color scheme explicitly (or via a theme added later).
- Contrast tests cover token pairs only, not every combination a consumer builds.
- WCAG's sRGB cutoff (0.04045) is used; older text cites 0.03928, the difference is negligible here.