
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

VaneKit brings **semantic design tokens**, **reusable SwiftUI components**, and **application-owned color themes** into one versioned Swift package. Build consistent interfaces across screens and products while keeping each application's visual identity independent.

## What's inside

| | Included |
|---|---|
| **Design tokens** | Semantic colors, spacing, typography, corner radius |
| **Theming** | Application-owned light/dark palettes, SwiftUI environment injection, nested theme overrides |
| **Components** | `VaneButtonStyle`, `VaneTextField`, `VaneBadge`, `VaneCard`, `VaneListRow`, `VaneEmptyState` |
| **Quality checks** | Color contrast tests, iOS Simulator snapshot tests, DocC documentation |

## Get started

**Requirements:** iOS 17+ · macOS 14+ · Swift 6.0

In Xcode, choose **File → Add Package Dependencies**, then enter:

```text
https://github.com/enjelhutasoit/VaneKit
```

Select version **1.1.0 or later** within a compatible major version to use custom theming.

For a Swift package manifest:

```swift
.package(
    url: "https://github.com/enjelhutasoit/VaneKit",
    from: "1.1.0"
)
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

            Button("Save") {
                // Handle save
            }
            .buttonStyle(VaneButtonStyle(.primary))
        }
        .padding(VaneSpacing.md)
    }
}
```

Components accept caller-provided text; localize strings in your application.

**No theme configuration is required.** VaneKit automatically uses its built-in light and dark color palettes.

## Customize colors

Starting with **v1.1.0**, VaneKit supports application-owned color themes.

Each application defines its own semantic palettes while VaneKit handles component styling and color resolution.

### 1. Define your theme

Use `VaneThemePalette` to define semantic colors for light and dark appearances.

```swift
import SwiftUI
import VaneKit

enum AppTheme {
    @MainActor
    static let theme = VaneTheme(
        light: VaneThemePalette(
            background: .white,
            surface: Color(
                .sRGB,
                red: 0.97,
                green: 0.97,
                blue: 0.99
            ),
            textPrimary: .black,
            textSecondary: .gray,
            accent: .indigo,
            onAccent: .white,
            critical: .red,
            onCritical: .white
        ),
        dark: VaneThemePalette(
            background: .black,
            surface: Color(
                .sRGB,
                red: 0.13,
                green: 0.13,
                blue: 0.17
            ),
            textPrimary: .white,
            textSecondary: .gray,
            accent: .mint,
            onAccent: .black,
            critical: .orange,
            onCritical: .black
        )
    )
}
```

These colors demonstrate the API and are not a validated production palette. Applications must verify accessibility and contrast for their chosen colors.

### 2. Apply the theme

Inject the theme at your application's root view.

```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView()
                .vaneTheme(AppTheme.theme)
        }
    }
}
```

All descendant VaneKit components inherit the theme automatically.

SwiftUI selects the appropriate light or dark palette based on the active color scheme.

### 3. Use components normally

No additional color configuration is required for individual components.

```swift
struct AccountView: View {
    var body: some View {
        VStack(spacing: VaneSpacing.md) {
            VaneBadge("Active", kind: .accent)

            VaneCard {
                VaneListRow(
                    "Account",
                    subtitle: "Primary account"
                )
            }

            Button("Continue") {
                // Handle action
            }
            .buttonStyle(VaneButtonStyle(.primary))
        }
        .padding(VaneSpacing.md)
    }
}
```

The components resolve their colors through the active `VaneTheme`.

### 4. Use semantic colors in custom views

Application-specific views can read the same theme through SwiftUI Environment.

```swift
struct AccountHeader: View {
    @Environment(\.vaneTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Text("My Accounts")
            .foregroundStyle(
                theme.color(.textPrimary, for: colorScheme)
            )
            .padding(VaneSpacing.md)
            .background(
                theme.color(.surface, for: colorScheme)
            )
    }
}
```

Available semantic roles:

| Role | Purpose |
|---|---|
| `background` | Screen backgrounds |
| `surface` | Cards and controls |
| `textPrimary` | Primary content |
| `textSecondary` | Supporting content |
| `accent` | Interactive emphasis |
| `onAccent` | Content displayed on accent |
| `critical` | Errors and destructive actions |
| `onCritical` | Content displayed on critical |

### 5. Override a theme locally

SwiftUI Environment supports independently scoped themes.

```swift
struct ThemePreview: View {
    var body: some View {
        VStack {
            VaneBadge("Default", kind: .accent)

            VaneBadge("Custom", kind: .accent)
                .vaneTheme(AppTheme.theme)
        }
    }
}
```

The nested theme applies only to its view hierarchy.

No global mutable state or singleton is required.

### Multi-brand architecture

VaneKit remains independent of consumer brand identities.

| VaneKit owns | Applications own |
|---|---|
| Semantic color roles | Brand colors |
| Theme configuration API | Light/dark brand palettes |
| Environment-based injection | Application theme setup |
| Reusable components | Product-specific interfaces |
| Default theme and SDK tests | Brand-specific visual tests |

Multiple applications can share the same VaneKit package without sharing their branding implementations.

For complete integration instructions, see [Adopting VaneKit](Sources/VaneKit/VaneKit.docc/AdoptingVaneKit.md).

## Backward compatibility

VaneKit v1.1.0 introduces custom themes as an additive feature.

Existing applications using the built-in theme do not need to migrate.

- Existing public component initializers remain unchanged.
- Existing semantic color roles remain available.
- The built-in theme remains the default.
- `VaneTheme.standard` provides the default light and dark palettes.
- `VaneColor.color(_:for:)` continues to resolve built-in default colors.

**Note:** `VaneColor.color(_:for:)` does not read the injected theme. Custom application views should use `@Environment(\.vaneTheme)` to resolve application-owned colors.

## Accessibility

VaneKit includes accessibility-focused design decisions and automated checks for its built-in palettes.

| Area | Coverage |
|---|---|
| Default color contrast | Automated unit tests |
| Component appearance | iOS Simulator snapshot tests |
| Generic custom themes | Light/dark snapshot tests |
| Dynamic Type | System text styles and accessibility-size snapshot |
| VoiceOver | Requires application-level verification |
| Consumer brand contrast | Consumer responsibility |

Custom themes are not automatically guaranteed to meet contrast requirements.

Applications should validate their own palettes, interaction states, Dynamic Type behavior, and accessibility before release.

See [Accessibility](Sources/VaneKit/VaneKit.docc/Accessibility.md) for implementation details.

## Documentation

- [Adopting VaneKit](Sources/VaneKit/VaneKit.docc/AdoptingVaneKit.md) — installation, theme integration, migration, and adoption
- [Tokens](Sources/VaneKit/VaneKit.docc/Tokens.md) — semantic colors, typography, spacing, and radius
- [Components](Sources/VaneKit/VaneKit.docc/Components.md) — available reusable UI components
- [Accessibility](Sources/VaneKit/VaneKit.docc/Accessibility.md) — accessibility decisions and coverage

In Xcode, open `Package.swift` and choose **Product → Build Documentation**.

CI also uploads a DocC archive as the `docc` artifact.

## Tested and versioned

VaneKit uses XCTest and automated CI checks to support reliable SDK development.

- `swift test` covers package logic and default color contrast.
- iOS Simulator tests cover component behavior and snapshots.
- Generic custom-theme snapshots verify light and dark appearances.
- DocC is built with warnings treated as errors.
- Release scripts are tested automatically.

Releases follow [Semantic Versioning](docs/versioning.md).

The v1.1.0 release introduces application-owned semantic color themes while preserving the existing public component APIs.

See the [changelog](CHANGELOG.md) and [releases](https://github.com/enjelhutasoit/VaneKit/releases) for details.

## Built independently

VaneKit is clean-room work informed by public Apple Human Interface Guidelines and WCAG guidance. No employer or client code, token values, or component APIs were reused.

Design decisions are documented in [architecture decision records](docs/adr).

## License

[MIT](LICENSE)
