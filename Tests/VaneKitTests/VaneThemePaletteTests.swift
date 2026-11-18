//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI
import XCTest
@testable import VaneKit

final class VaneThemePaletteTests: XCTestCase {

    func test_palette_resolvesEverySemanticColorRole() {
        let expected: [(VaneColorRole, Color)] = [
            (.background, .white),
            (.surface, .gray),
            (.textPrimary, .black),
            (.textSecondary, .brown),
            (.accent, .yellow),
            (.onAccent, .black),
            (.critical, .red),
            (.onCritical, .white)
        ]

        let palette = makePalette(accent: .yellow)

        for (role, color) in expected {
            XCTAssertEqual(
                palette[role],
                color,
                "Incorrect color for \(role)"
            )
        }
    }

    func test_palettes_preserveIndependentBrandColors() {
        let teBank = makePalette(accent: .yellow)
        let anotherBank = makePalette(accent: .blue)

        XCTAssertEqual(teBank[.accent], .yellow)
        XCTAssertEqual(anotherBank[.accent], .blue)

        XCTAssertEqual(teBank[.background], .white)
        XCTAssertEqual(anotherBank[.background], .white)
    }

    private func makePalette(accent: Color) -> VaneThemePalette {
        VaneThemePalette(
            background: .white,
            surface: .gray,
            textPrimary: .black,
            textSecondary: .brown,
            accent: accent,
            onAccent: .black,
            critical: .red,
            onCritical: .white
        )
    }
}
