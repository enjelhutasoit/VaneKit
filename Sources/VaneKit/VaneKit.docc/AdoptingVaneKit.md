# Adopting VaneKit

Add the package, start with tokens, then move screens over one at a time.

## Requirements

- iOS 17 or macOS 14
- A Swift 6.0 toolchain (the package uses swift-tools-version 6.0)

## Install

After the first tagged release, add the package in Xcode (File > Add Package
Dependencies) or in `Package.swift`:

```swift
.package(url: "https://github.com/enjelhutasoit/VaneKit", from: "1.0.0")
```

Pin to a minor version if your team wants to review every change:
`.upToNextMinor(from: "1.0.0")`.

## Use a component

Components read the color scheme from the environment. Pass localized strings.

```swift
import SwiftUI
import VaneKit

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var name = ""
    let onSave: () -> Void

    var body: some View {
        VaneCard {
            VaneTextField(String(localized: "profile.name"), text: $name)
            Button(String(localized: "profile.save"), action: onSave)
                .buttonStyle(VaneButtonStyle(.primary))
        }
        .padding(VaneSpacing.md)
        .background(VaneColor.color(.background, for: colorScheme))
    }
}
```

## Roll out in steps

1. Pick one screen with a team that agrees to give feedback.
2. Replace hard-coded colors, spacing and fonts with tokens first.
3. Replace controls with components when a token-only change is not enough.
4. Review the changelog before raising the version in each app.

## What VaneKit does not do

VaneKit has no theme injection, custom fonts, icon set, navigation,
animations, or localized strings. Keep those in your app.

## Related

- <doc:Accessibility>
- <doc:Tokens>
- <doc:Components>
