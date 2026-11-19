# Changelog

All notable changes are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). 
See `docs/versioning.md`.

## [Unreleased]

## [1.1.0]

### Added

- Public `VaneTheme` and `VaneThemePalette` APIs for application-owned
  semantic color themes.
- SwiftUI environment-based theme injection through `.vaneTheme(_:)`.
- Support for independent light and dark color palettes.
- Nested theme overrides within SwiftUI view hierarchies.
- Generic custom-theme snapshot coverage for light and dark appearances.
- Theme integration and backward compatibility tests.

### Changed

- Components now resolve semantic colors from the active environment theme.
- Adoption documentation now covers custom themes, integration,
  accessibility responsibilities, and migration.

### Compatibility

- Existing consumers continue using the built-in default theme without
  configuration changes.
- Existing public component initializers and semantic color roles remain
  unchanged.
- `VaneColor.color(_:for:)` continues resolving the built-in default colors.
- Minimum supported platforms remain iOS 17 and macOS 14.
- Swift tools version remains 6.0.

## [1.0.0] - 2026-11-05

### Added

- Design tokens: semantic color roles with light and dark palettes, spacing,
  typography based on system text styles, and radius.
- Components: `VaneButtonStyle`, `VaneTextField`, `VaneBadge`, `VaneCard`,
  `VaneListRow`, `VaneEmptyState`.
- Contrast unit tests for token and component color pairs.
- Snapshot tests (iOS Simulator, CI only) and a DocC catalog with an adoption guide.
