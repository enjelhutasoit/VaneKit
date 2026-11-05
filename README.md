# VaneKit

A clean-room SwiftUI mini design system: design tokens, accessible components,
DocC documentation, snapshot tests and a SemVer Swift Package Manager release flow.

## Status

Available: tokens (color, spacing, typography, radius) and components:
`VaneButtonStyle`, `VaneTextField`, `VaneBadge`, `VaneCard`, `VaneListRow`, `VaneEmptyState`.
Snapshot tests, DocC and the release flow are not implemented yet. See the roadmap below.

## Clean-room statement

Names, token values and APIs were designed
independently from public sources (Apple Human Interface Guidelines, WCAG).
No source code, token values, component APIs or documentation from any
employer or client were used. Design decisions are recorded in `docs/adr`.

## Installation (after the first release)

Xcode > File > Add Package Dependencies > `https://github.com/enjelhutasoit/VaneKit`
and select a tag. Requires iOS 17 / macOS 14, Swift 6.

## Roadmap

1. Tokens: color, spacing, typography, radius
2. Components: button, text field, badge, card, list row, empty state
3. Snapshot and accessibility tests
4. DocC catalog and adoption guide
5. Tag-driven SemVer release (v1.0.0)

## License

MIT
