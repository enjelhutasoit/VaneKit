# VaneKit

A clean-room SwiftUI mini design system: design tokens, accessible components,
DocC documentation, snapshot tests and a SemVer Swift Package Manager release flow.

## Status

Available: tokens (color, spacing, typography, radius) and components:
`VaneButtonStyle`, `VaneTextField`, `VaneBadge`, `VaneCard`, `VaneListRow`, `VaneEmptyState`.
Current version: see Releases.

## Versioning

VaneKit follows Semantic Versioning. See `docs/versioning.md` for the rules and
deprecation policy, `docs/releasing.md` for the release steps, and `CHANGELOG.md`.


## Documentation

DocC sources live in `Sources/VaneKit/VaneKit.docc`. In Xcode, open `Package.swift`
and choose Product > Build Documentation. 
CI uploads the DocC archive as a .tar.gz inside the docc artifact

## Clean-room statement

Names, token values and APIs were designed
independently from public sources (Apple Human Interface Guidelines, WCAG).
No source code, token values, component APIs or documentation from any
employer or client were used. Design decisions are recorded in `docs/adr`.

## Installation (after the first release)

Xcode > File > Add Package Dependencies > `https://github.com/enjelhutasoit/VaneKit`
and select a tag. Requires iOS 17 / macOS 14, Swift 6.

## Testing

- `swift test` runs logic and contrast tests on macOS.
- Snapshot tests run on the iOS Simulator in CI only. References are recorded
  from CI artifacts; see `docs/adr/0005-snapshot-policy.md`.

## Roadmap

1. Tokens: color, spacing, typography, radius
2. Components: button, text field, badge, card, list row, empty state
3. Snapshot and accessibility tests
4. DocC catalog and adoption guide
5. Tag-driven SemVer release (v1.0.0)

## License

MIT
