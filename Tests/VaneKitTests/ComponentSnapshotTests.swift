//
// Copyright (c) 2026 Enjel Hutasoit
//

#if os(iOS)
import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class ComponentSnapshotTests: XCTestCase {
    private enum Tolerance {
        static let precision: Float = 0.995
        static let perceptualPrecision: Float = 0.98
    }

    func test_gallery_light_defaultTextSize_matchesReference() {
        assertGallery(scheme: .light, textSize: .large)
    }

    func test_gallery_dark_defaultTextSize_matchesReference() {
        assertGallery(scheme: .dark, textSize: .large)
    }

    func test_gallery_light_accessibilityTextSize_matchesReference() {
        assertGallery(scheme: .light, textSize: .accessibility3)
    }

    private func assertGallery(
        scheme: ColorScheme,
        textSize: DynamicTypeSize,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        let view = ComponentGallery(scheme: scheme)
            .environment(\.colorScheme, scheme)
            .environment(\.dynamicTypeSize, textSize)

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
