//
// Copyright (c) 2026 Enjel Hutasoit
//

import XCTest
@testable import VaneKit

final class VaneColorPaletteTests: XCTestCase {
    private typealias Pair = (foreground: VaneColorRole, background: VaneColorRole)

    private let minimumTextContrast = 4.5
    private let minimumNonTextContrast = 3.0
    private let palettes: [(name: String, palette: VaneColorPalette)] = [
        ("light", .light),
        ("dark", .dark)
    ]

    func test_palette_textRoles_meetMinimumTextContrast() {
        assertContrast(
            [
                (.textPrimary, .background),
                (.textPrimary, .surface),
                (.textSecondary, .background),
                (.textSecondary, .surface),
                (.onAccent, .accent),
                (.onCritical, .critical)
            ],
            atLeast: minimumTextContrast
        )
    }

    func test_palette_accentAndCritical_meetNonTextContrastOnBackgrounds() {
        assertContrast(
            [
                (.accent, .background),
                (.accent, .surface),
                (.critical, .background),
                (.critical, .surface)
            ],
            atLeast: minimumNonTextContrast
        )
    }

    private func assertContrast(
        _ pairs: [Pair],
        atLeast minimum: Double,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for (name, palette) in palettes {
            for pair in pairs {
                let ratio = palette[pair.foreground].contrastRatio(with: palette[pair.background])
                XCTAssertGreaterThanOrEqual(
                    ratio,
                    minimum,
                    "\(name): \(pair.foreground) on \(pair.background)",
                    file: file,
                    line: line
                )
            }
        }
    }
}
