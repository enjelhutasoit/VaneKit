//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// A product's semantic color configuration.
///
/// Each theme defines separate light and dark palettes.
/// Components resolve their colors using the active
/// SwiftUI color scheme.
public struct VaneTheme {

    public let light: VaneThemePalette
    public let dark: VaneThemePalette

    /// Creates a theme with explicit light and dark palettes.
    public init(
        light: VaneThemePalette,
        dark: VaneThemePalette
    ) {
        self.light = light
        self.dark = dark
    }

    /// Returns the palette for the requested color scheme.
    public func palette(
        for scheme: ColorScheme
    ) -> VaneThemePalette {
        scheme == .dark ? dark : light
    }

    /// Resolves a semantic color role.
    public func color(
        _ role: VaneColorRole,
        for scheme: ColorScheme
    ) -> Color {
        palette(for: scheme)[role]
    }

    /// Original VaneKit colors, preserved for existing users.
    public static var standard: VaneTheme {
        VaneTheme(
            light: makePalette(from: .light),
            dark: makePalette(from: .dark)
        )
    }

    private static func makePalette(
        from source: VaneColorPalette
    ) -> VaneThemePalette {
        VaneThemePalette(
            background: Color(source[.background]),
            surface: Color(source[.surface]),
            textPrimary: Color(source[.textPrimary]),
            textSecondary: Color(source[.textSecondary]),
            accent: Color(source[.accent]),
            onAccent: Color(source[.onAccent]),
            critical: Color(source[.critical]),
            onCritical: Color(source[.onCritical])
        )
    }
}
