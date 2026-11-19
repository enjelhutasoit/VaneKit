//
// Copyright (c) 2026 Enjel Hutasoit
//

#if os(iOS)

import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class ThemeSnapshotTests: XCTestCase {

    private enum Tolerance {
        static let precision: Float = 0.995
        static let perceptualPrecision: Float = 0.98
    }

    func test_customTheme_light_matchesReference() {
        assertGallery(scheme: .light)
    }

    func test_customTheme_dark_matchesReference() {
        assertGallery(scheme: .dark)
    }

    private func assertGallery(
        scheme: ColorScheme,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        let view = ComponentGallery(scheme: scheme)
            .vaneTheme(TestThemeFixture.theme)
            .environment(\.colorScheme, scheme)
            .environment(\.dynamicTypeSize, .large)

        assertSnapshot(
            of: view,
            as: .image(
                precision: Tolerance.precision,
                perceptualPrecision: Tolerance.perceptualPrecision,
                layout: .sizeThatFits
            ),
            file: file,
            testName: testName,
            line: line
        )
    }
}

#endif
