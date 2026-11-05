//
// Copyright (c) 2026 Enjel Hutasoit
//

import XCTest
@testable import VaneKit

final class ComponentColorsTests: XCTestCase {
    private let minimumTextContrast = 4.5
    private let minimumNonTextContrast = 3.0
    private let palettes: [(name: String, palette: VaneColorPalette)] = [
        ("light", .light),
        ("dark", .dark)
    ]

    func test_buttonKinds_labelMeetsTextContrast() {
        assertTextContrast(VaneButtonKind.allCases.map { (String(describing: $0), $0.colors) })
    }

    func test_badgeKinds_labelMeetsTextContrast() {
        assertTextContrast(VaneBadgeKind.allCases.map { (String(describing: $0), $0.colors) })
    }

    func test_componentBorders_meetNonTextContrastAgainstOwnBackground() {
        let all = VaneButtonKind.allCases.map { (String(describing: $0), $0.colors) }
            + VaneBadgeKind.allCases.map { (String(describing: $0), $0.colors) }

        for (name, palette) in palettes {
            for (kind, colors) in all {
                guard let border = colors.border else { continue }
                let ratio = palette[border].contrastRatio(with: palette[colors.background])
                XCTAssertGreaterThanOrEqual(ratio, minimumNonTextContrast, "\(name): \(kind) border")
            }
        }
    }

    func test_fieldErrorText_meetsTextContrastOnBackgroundAndSurface() {
        for (name, palette) in palettes {
            for background in [VaneColorRole.background, .surface] {
                let ratio = palette[.critical].contrastRatio(with: palette[background])
                XCTAssertGreaterThanOrEqual(ratio, minimumTextContrast, "\(name): critical on \(background)")
            }
        }
    }

    private func assertTextContrast(
        _ items: [(name: String, colors: VaneComponentColors)],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for (schemeName, palette) in palettes {
            for item in items {
                let ratio = palette[item.colors.foreground].contrastRatio(with: palette[item.colors.background])
                XCTAssertGreaterThanOrEqual(
                    ratio,
                    minimumTextContrast,
                    "\(schemeName): \(item.name)",
                    file: file,
                    line: line
                )
            }
        }
    }
}
