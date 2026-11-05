//
// Copyright (c) 2026 Enjel Hutasoit
//

import XCTest
@testable import VaneKit

final class VaneFieldMessageTests: XCTestCase {
    func test_resolve_errorTakesPrecedenceOverHelper() {
        let message = VaneFieldMessage.resolve(helper: "Use 8 digits", error: "Required")

        XCTAssertEqual(message, VaneFieldMessage(kind: .error, text: "Required"))
    }

    func test_resolve_blankError_fallsBackToHelper() {
        let message = VaneFieldMessage.resolve(helper: "Use 8 digits", error: "   ")

        XCTAssertEqual(message, VaneFieldMessage(kind: .helper, text: "Use 8 digits"))
    }

    func test_resolve_onlyWhitespace_returnsNil() {
        XCTAssertNil(VaneFieldMessage.resolve(helper: " \n", error: "\t"))
    }

    func test_resolve_nilInputs_returnsNil() {
        XCTAssertNil(VaneFieldMessage.resolve(helper: nil, error: nil))
    }

    func test_resolve_trimsSurroundingWhitespace() {
        let message = VaneFieldMessage.resolve(helper: nil, error: "  Required \n")

        XCTAssertEqual(message?.text, "Required")
    }
}
