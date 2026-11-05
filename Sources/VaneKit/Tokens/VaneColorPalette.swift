//
// Copyright (c) 2026 Enjel Hutasoit
//

struct VaneColorPalette: Sendable {
    let background: SRGBColor
    let surface: SRGBColor
    let textPrimary: SRGBColor
    let textSecondary: SRGBColor
    let accent: SRGBColor
    let onAccent: SRGBColor
    let critical: SRGBColor
    let onCritical: SRGBColor

    subscript(role: VaneColorRole) -> SRGBColor {
        switch role {
        case .background: background
        case .surface: surface
        case .textPrimary: textPrimary
        case .textSecondary: textSecondary
        case .accent: accent
        case .onAccent: onAccent
        case .critical: critical
        case .onCritical: onCritical
        }
    }

    static let light = VaneColorPalette(
        background: SRGBColor(red: 247, green: 248, blue: 250),
        surface: SRGBColor(red: 255, green: 255, blue: 255),
        textPrimary: SRGBColor(red: 20, green: 27, blue: 45),
        textSecondary: SRGBColor(red: 74, green: 85, blue: 104),
        accent: SRGBColor(red: 11, green: 95, blue: 209),
        onAccent: SRGBColor(red: 255, green: 255, blue: 255),
        critical: SRGBColor(red: 179, green: 38, blue: 30),
        onCritical: SRGBColor(red: 255, green: 255, blue: 255)
    )

    static let dark = VaneColorPalette(
        background: SRGBColor(red: 15, green: 17, blue: 21),
        surface: SRGBColor(red: 26, green: 29, blue: 36),
        textPrimary: SRGBColor(red: 242, green: 244, blue: 248),
        textSecondary: SRGBColor(red: 168, green: 176, blue: 191),
        accent: SRGBColor(red: 106, green: 166, blue: 255),
        onAccent: SRGBColor(red: 15, green: 17, blue: 21),
        critical: SRGBColor(red: 255, green: 138, blue: 128),
        onCritical: SRGBColor(red: 15, green: 17, blue: 21)
    )
}
