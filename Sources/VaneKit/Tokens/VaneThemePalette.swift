//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// Semantic colors supplied by an application.
///
/// Each color represents a design role rather than
/// a product-specific color name.
///
/// Applications provide their own palettes while
/// VaneKit components remain brand-independent.
public struct VaneThemePalette {

    public let background: Color
    public let surface: Color

    public let textPrimary: Color
    public let textSecondary: Color

    public let accent: Color
    public let onAccent: Color

    public let critical: Color
    public let onCritical: Color

    /// Creates a complete semantic color palette.
    public init(
        background: Color,
        surface: Color,
        textPrimary: Color,
        textSecondary: Color,
        accent: Color,
        onAccent: Color,
        critical: Color,
        onCritical: Color
    ) {
        self.background = background
        self.surface = surface
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.accent = accent
        self.onAccent = onAccent
        self.critical = critical
        self.onCritical = onCritical
    }

    /// Returns the color assigned to a semantic role.
    public subscript(role: VaneColorRole) -> Color {
        switch role {
        case .background:
            background
        case .surface:
            surface
        case .textPrimary:
            textPrimary
        case .textSecondary:
            textSecondary
        case .accent:
            accent
        case .onAccent:
            onAccent
        case .critical:
            critical
        case .onCritical:
            onCritical
        }
    }
}
