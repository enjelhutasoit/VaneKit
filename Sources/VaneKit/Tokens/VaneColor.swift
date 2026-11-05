//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// Resolves ``VaneColorRole`` values to SwiftUI colors.
public enum VaneColor {
    /// The color for `role` in the given color scheme.
    ///
    /// - Parameters:
    ///   - role: The semantic role.
    ///   - scheme: Usually the value of `@Environment(\.colorScheme)`.
    public static func color(_ role: VaneColorRole, for scheme: ColorScheme) -> Color {
        let palette: VaneColorPalette = scheme == .dark ? .dark : .light
        return Color(palette[role])
    }
}

extension Color {
    init(_ color: SRGBColor) {
        self.init(
            .sRGB,
            red: Double(color.red) / SRGBColor.channelMax,
            green: Double(color.green) / SRGBColor.channelMax,
            blue: Double(color.blue) / SRGBColor.channelMax
        )
    }
}
