//
// Copyright (c) 2026 Enjel Hutasoit
//

import XCTest
@testable import VaneKit

final class SRGBColorTests: XCTestCase {
    private let black = SRGBColor(red: 0, green: 0, blue: 0)
    private let white = SRGBColor(red: 255, green: 255, blue: 255)

    func test_contrastRatio_blackOnWhite_isTwentyOne() {
        XCTAssertEqual(black.contrastRatio(with: white), 21, accuracy: 0.01)
    }

    func test_contrastRatio_isSymmetric() {
        let grey = SRGBColor(red: 118, green: 118, blue: 118)
        XCTAssertEqual(
            grey.contrastRatio(with: white),
            white.contrastRatio(with: grey),
            accuracy: 0.0001
        )
    }

    func test_contrastRatio_identicalColors_isOne() {
        XCTAssertEqual(white.contrastRatio(with: white), 1, accuracy: 0.0001)
    }

    func test_contrastRatio_grey767676OnWhite_isJustAboveAAThreshold() {
        let grey = SRGBColor(red: 0x76, green: 0x76, blue: 0x76)
        XCTAssertEqual(grey.contrastRatio(with: white), 4.54, accuracy: 0.02)
    }
}
