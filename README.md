 
<p align="center">
  <img src="assets/vanekit-logo-medium-512.png" alt="VaneKit logo" width="220">
</p>

<h1 align="center">VaneKit</h1>

<p align="center">A focused SwiftUI design system for consistent, accessible interfaces.</p>

<p align="center">
  <a href="https://github.com/enjelhutasoit/VaneKit/actions/workflows/ci.yml"><img src="https://github.com/enjelhutasoit/VaneKit/actions/workflows/ci.yml/badge.svg?branch=main" alt="CI"></a>
  <a href="https://github.com/enjelhutasoit/VaneKit/releases/latest"><img src="https://img.shields.io/github/v/release/enjelhutasoit/VaneKit?label=release" alt="Latest release"></a>
  <a href="Package.swift"><img src="https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white" alt="Swift 6.0"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/enjelhutasoit/VaneKit" alt="License"></a>
</p>

VaneKit brings **semantic design tokens** and **reusable SwiftUI components** into one versioned Swift package. Start with a few tokens, adopt components as needed, and keep your app's look consistent across screens.

## What's inside

| | Included |
|---|---|
| **Design tokens** | Semantic colors (light/dark), spacing, typography, corner radius |
| **Components** | `VaneButtonStyle`, `VaneTextField`, `VaneBadge`, `VaneCard`, `VaneListRow`, `VaneEmptyState` |
| **Quality checks** | Contrast tests, iOS Simulator snapshot tests, DocC documentation |

## Get started

**Requirements:** iOS 17+ · macOS 14+ · Swift 6.0

In Xcode, choose **File → Add Package Dependencies**, then enter:

```text
https://github.com/enjelhutasoit/VaneKit
```

Select version **1.0.0** or later within a compatible major version. For a Swift package manifest:

```swift
.package(url: "https://github.com/enjelhutasoit/VaneKit", from: "1.0.0")
```

### Use a component

```swift
import SwiftUI
import VaneKit

struct ProfileView: View {
    @State private var name = ""

    var body: some View {
        VaneCard {
            VaneTextField("Name", text: $name)
            Button("Save") { /* Handle save */ }
                .buttonStyle(VaneButtonStyle(.primary))
        }
        .padding(VaneSpacing.md)
    }
}
```

Components accept caller-provided text; localize strings in your app. See the [adoption guide](Sources/VaneKit/VaneKit.docc/AdoptingVaneKit.md) for a complete example with semantic background colors.

## Documentation

- [Adopting VaneKit](Sources/VaneKit/VaneKit.docc/AdoptingVaneKit.md) — installation, example, and rollout steps
- [Tokens](Sources/VaneKit/VaneKit.docc/Tokens.md) and [Components](Sources/VaneKit/VaneKit.docc/Components.md) — available building blocks
- [Accessibility](Sources/VaneKit/VaneKit.docc/Accessibility.md) — accessibility decisions and coverage

In Xcode, open `Package.swift` and choose **Product → Build Documentation**. CI also uploads a DocC archive as the `docc` artifact.

## Tested and versioned

`swift test` covers package logic and color contrast. CI additionally runs iOS Simulator snapshots, builds DocC with warnings treated as errors, and checks release scripts.

Releases follow [Semantic Versioning](docs/versioning.md). See the [changelog](CHANGELOG.md) and [releases](https://github.com/enjelhutasoit/VaneKit/releases) for changes.

## Built independently

VaneKit is clean-room work informed by public Apple Human Interface Guidelines and WCAG guidance. No employer or client code, token values, or component APIs were reused. Design decisions are documented in [architecture decision records](docs/adr).

## License

[MIT](LICENSE)
