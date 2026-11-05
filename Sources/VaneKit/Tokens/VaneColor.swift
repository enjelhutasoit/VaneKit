//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

public enum VaneColor {
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
