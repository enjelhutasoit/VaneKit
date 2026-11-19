# Tokens

Semantic values that components and application views build on.

## Overview

VaneKit provides semantic color roles, spacing, typography,
and corner radius tokens.

Components use semantic color roles rather than raw brand colors.

By default, VaneKit resolves colors using its built-in light
and dark palettes.

Applications can inject custom palettes through `VaneTheme`.

## Custom Color Themes

`VaneThemePalette` defines eight semantic colors.

`VaneTheme` groups light and dark palettes.

Use `.vaneTheme(_:)` to inject a theme into a SwiftUI
view hierarchy.

Descendant components inherit the active theme.

See <doc:AdoptingVaneKit> for a complete integration example.

## Default Color Resolution

`VaneColor.color(_:for:)` remains available for consumers
using the built-in default palette.

This API does not read SwiftUI Environment.

Application views that need custom colors should resolve them
through `@Environment(\.vaneTheme)`.

## Typography

Typography maps to system text styles, so Dynamic Type
applies without additional setup.

Custom typography is not part of the v1.1.0 theme API.

## Topics

### Color

- ``VaneColorRole``
- ``VaneColor``
- ``VaneThemePalette``
- ``VaneTheme``

### Layout

- ``VaneSpacing``
- ``VaneRadius``
- ``VaneSize``

### Typography

- ``VaneTextStyle``
