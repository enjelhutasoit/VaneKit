//
// Copyright (c) 2026 Enjel Hutasoit
//

import XCTest
@testable import VaneKit

final class OptionalStringTrimTests: XCTestCase {
    func test_vaneTrimmedNonEmpty_nil_returnsNil() {
        let value: String? = nil

        XCTAssertNil(value.vaneTrimmedNonEmpty)
    }

    func test_vaneTrimmedNonEmpty_onlyWhitespaceAndNewlines_returnsNil() {
        let value: String? = " \t\n "

        XCTAssertNil(value.vaneTrimmedNonEmpty)
    }

    func test_vaneTrimmedNonEmpty_surroundingWhitespace_isRemoved() {
        let value: String? = "  Hello \n"

        XCTAssertEqual(value.vaneTrimmedNonEmpty, "Hello")
    }

    func test_vaneTrimmedNonEmpty_innerWhitespace_isPreserved() {
        let value: String? = "Hello  world"

        XCTAssertEqual(value.vaneTrimmedNonEmpty, "Hello  world")
    }
}
