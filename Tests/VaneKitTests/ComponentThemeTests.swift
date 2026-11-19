//
// Copyright (c) 2026 Enjel Hutasoit
//

#if canImport(UIKit)

import SwiftUI
import UIKit
import XCTest
@testable import VaneKit

@MainActor
final class ComponentThemeTests: XCTestCase {

    func test_components_renderDifferentlyForDifferentBrands() {
        let first = makeTheme(accent: .red, text: .red)
        let second = makeTheme(accent: .blue, text: .blue)

        let components: [(String, AnyView)] = [
            (
                "Button",
                AnyView(
                    Button("Transfer") {}
                        .buttonStyle(VaneButtonStyle(.primary))
                )
            ),
            (
                "Badge",
                AnyView(VaneBadge("Premium", kind: .accent))
            ),
            (
                "Card",
                AnyView(VaneCard { Text("Balance") })
            ),
            (
                "ListRow",
                AnyView(VaneListRow("Accounts"))
            ),
            (
                "EmptyState",
                AnyView(
                    VaneEmptyState(
                        systemImage: "tray",
                        title: "No transactions"
                    )
                )
            ),
            (
                "TextField",
                AnyView(
                    VaneTextField(
                        "Account",
                        text: .constant("")
                    )
                )
            )
        ]

        for (name, component) in components {
            let firstImage = render(
                component.vaneTheme(first)
            )

            let secondImage = render(
                component.vaneTheme(second)
            )

            XCTAssertNotEqual(
                firstImage.pngData(),
                secondImage.pngData(),
                "\(name) ignored the active theme"
            )
        }
    }

    func test_component_usesDarkPalette() {
        let theme = VaneTheme(
            light: makePalette(
                accent: .red,
                text: .black
            ),
            dark: makePalette(
                accent: .green,
                text: .white
            )
        )

        let component = VaneBadge(
            "Premium",
            kind: .accent
        )

        let light = render(
            component
                .vaneTheme(theme)
                .environment(\.colorScheme, .light)
        )

        let dark = render(
            component
                .vaneTheme(theme)
                .environment(\.colorScheme, .dark)
        )

        XCTAssertNotEqual(
            light.pngData(),
            dark.pngData()
        )
    }

    func test_component_usesNestedTheme() {
        let parent = makeTheme(
            accent: .red,
            text: .red
        )

        let child = makeTheme(
            accent: .blue,
            text: .blue
        )

        let component = VaneBadge(
            "Premium",
            kind: .accent
        )

        let inherited = render(
            component.vaneTheme(parent)
        )

        let overridden = render(
            component
                .vaneTheme(child)
                .vaneTheme(parent)
        )

        XCTAssertNotEqual(
            inherited.pngData(),
            overridden.pngData()
        )
    }

    private func makeTheme(
        accent: Color,
        text: Color
    ) -> VaneTheme {
        let palette = makePalette(
            accent: accent,
            text: text
        )

        return VaneTheme(
            light: palette,
            dark: palette
        )
    }

    private func makePalette(
        accent: Color,
        text: Color
    ) -> VaneThemePalette {
        VaneThemePalette(
            background: .white,
            surface: accent,
            textPrimary: text,
            textSecondary: text,
            accent: accent,
            onAccent: .white,
            critical: accent,
            onCritical: .white
        )
    }

    private func render<Content: View>(
        _ content: Content
    ) -> UIImage {
        let view = content
            .frame(width: 320, height: 160)
            .background(Color.white)

        let renderer = ImageRenderer(content: view)
        renderer.scale = 1

        guard let image = renderer.uiImage else {
            XCTFail("ImageRenderer returned nil")
            return UIImage()
        }

        return image
    }
}

#endif
