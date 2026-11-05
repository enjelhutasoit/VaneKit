//
// Copyright (c) 2026 Enjel Hutasoit
//

import Foundation

/// An 8-bit-per-channel sRGB color with WCAG 2.x contrast math.
struct SRGBColor: Equatable, Sendable {
    static let channelMax: Double = 255

    let red: UInt8
    let green: UInt8
    let blue: UInt8

    var relativeLuminance: Double {
        Self.linearize(red) * Coefficient.red
            + Self.linearize(green) * Coefficient.green
            + Self.linearize(blue) * Coefficient.blue
    }

    func contrastRatio(with other: SRGBColor) -> Double {
        let lighter = max(relativeLuminance, other.relativeLuminance)
        let darker = min(relativeLuminance, other.relativeLuminance)
        return (lighter + Coefficient.flare) / (darker + Coefficient.flare)
    }

    private static func linearize(_ channel: UInt8) -> Double {
        let value = Double(channel) / channelMax
        guard value > Gamma.linearCutoff else { return value / Gamma.linearSlope }
        return pow((value + Gamma.offset) / Gamma.scale, Gamma.exponent)
    }

    private enum Coefficient {
        static let red = 0.2126
        static let green = 0.7152
        static let blue = 0.0722
        static let flare = 0.05
    }

    private enum Gamma {
        static let linearCutoff = 0.04045
        static let linearSlope = 12.92
        static let offset = 0.055
        static let scale = 1.055
        static let exponent = 2.4
    }
}
