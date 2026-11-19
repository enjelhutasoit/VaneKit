# Adopting VaneKit

Integrate reusable SwiftUI components with default or application-owned
semantic color themes.

## Requirements

- iOS 17+ or macOS 14+
- Swift 6.0 toolchain

## Install

Add VaneKit through Xcode's **File > Add Package Dependencies**, or use
Swift Package Manager:

```swift
.package(
    url: "https://github.com/enjelhutasoit/VaneKit",
    from: "1.1.0"
)
```

Custom themes are introduced in v1.1.0. Until that release is published,
test the feature using the development branch or an approved release
candidate.

Existing consumers using v1.0.0 can continue using VaneKit without a
custom theme.

## Use the Default Theme

VaneKit provides default semantic colors for light and dark appearances.

```swift
import SwiftUI
import VaneKit

struct ProfileView: View {
    @State private var name = ""

    var body: some View {
        VaneCard {
            VaneTextField("Name", text: $name)

            Button("Save") {}
                .buttonStyle(VaneButtonStyle(.primary))
        }
        .padding(VaneSpacing.md)
    }
}
```

No theme configuration is required.

## Define an Application Theme

Applications own their visual identity. VaneKit does not contain
consumer-specific brand colors.

Create an application-owned theme using `VaneTheme` and
`VaneThemePalette`.

```swift
import SwiftUI
import VaneKit

enum AppTheme {
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

These colors demonstrate the API. They are not a validated production
palette. Consumer applications must verify contrast and accessibility.

## Inject the Theme

Apply the theme to the application's root view:

```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .vaneTheme(AppTheme.theme)
        }
    }
}
```

Descendant VaneKit components automatically inherit the theme.

The active color scheme selects the corresponding light or dark palette.

## Read Semantic Colors in Application Views

Custom application views can read the same theme through SwiftUI
Environment.

```swift
struct AccountHeader: View {
    @Environment(\.vaneTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Text("Accounts")
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

`VaneColor.color(_:for:)` remains available for compatibility.
It resolves the built-in default colors and does not read the injected
theme.

Use the environment theme when application views must follow custom
branding.

## Override a Theme for a Subtree

SwiftUI Environment supports nested theme scopes.

```swift
struct PreviewScreen: View {
    var body: some View {
        VStack {
            VaneBadge("Default scope", kind: .accent)

            VaneBadge("Custom scope", kind: .accent)
                .vaneTheme(AppTheme.theme)
        }
    }
}
```

The nested theme applies only to its view hierarchy.

Theme injection does not modify a global singleton.

## Semantic Color Roles

Every palette defines eight roles:

| Role | Purpose |
|---|---|
| `background` | Screen background |
| `surface` | Cards and controls |
| `textPrimary` | Primary content |
| `textSecondary` | Supporting content |
| `accent` | Interactive emphasis |
| `onAccent` | Content on accent |
| `critical` | Error and destructive emphasis |
| `onCritical` | Content on critical |

Choose colors based on semantic purpose, not product-specific names.

The application should maintain separate light and dark palettes.

## Accessibility Responsibilities

VaneKit includes contrast checks for its built-in default palettes.

Those checks do not automatically validate arbitrary consumer colors.

Before release, consumer applications should:

1. Verify text and component contrast in both appearances.
2. Test disabled, focused, error, and destructive states.
3. Validate Dynamic Type and VoiceOver behavior.
4. Review brand-specific visual snapshots.
5. Avoid using color alone to communicate meaning.

## Migration from v1.0.0

Existing integrations require no code changes.

The built-in default palette remains available through
`VaneTheme.standard`.

To adopt custom colors:

1. Update the VaneKit dependency to v1.1.0 after publication.
2. Define application-owned light and dark palettes.
3. Construct a `VaneTheme`.
4. Inject it using `.vaneTheme(_:)`.
5. Validate component appearance and accessibility.

Existing public component initializers and semantic color roles remain
unchanged.

## What VaneKit Does Not Own

VaneKit does not own consumer brand identities, navigation, localized
strings, custom icon libraries, or application-specific visual testing.

Its theme configuration currently supports semantic colors only.

Typography, spacing, and radius customization are outside the v1.1.0
theme API.

## Related

- <doc:Tokens>
- <doc:Components>
- <doc:Accessibility>
