//
// Copyright (c) 2026 Enjel Hutasoit
//

#if os(iOS)

import SwiftUI
import VaneKit

/// Test-only colors for validating custom theme rendering.
///
/// These colors do not represent any consumer brand.
enum TestThemeFixture {

    @MainActor
    static let theme = VaneTheme(
        light: VaneThemePalette(
            background: rgb(0xF5, 0xF5, 0xFB),
            surface: .white,
            textPrimary: rgb(0x17, 0x13, 0x29),
            textSecondary: rgb(0x51, 0x4B, 0x65),
            accent: rgb(0x55, 0x33, 0x99),
            onAccent: .white,
            critical: rgb(0xB3, 0x26, 0x1E),
            onCritical: .white
        ),
        dark: VaneThemePalette(
            background: rgb(0x11, 0x11, 0x1B),
            surface: rgb(0x24, 0x24, 0x38),
            textPrimary: rgb(0xF5, 0xF5, 0xFF),
            textSecondary: rgb(0xC2, 0xBF, 0xDB),
            accent: rgb(0xB5, 0xA0, 0xFF),
            onAccent: rgb(0x11, 0x11, 0x1B),
            critical: rgb(0xFF, 0xB4, 0xAB),
            onCritical: rgb(0x11, 0x11, 0x1B)
        )
    )

    private static func rgb(
        _ red: UInt8,
        _ green: UInt8,
        _ blue: UInt8
    ) -> Color {
        Color(
            .sRGB,
            red: Double(red) / 255.0,
            green: Double(green) / 255.0,
            blue: Double(blue) / 255.0,
            opacity: 1
        )
    }
}

#endif
