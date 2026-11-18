//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI
import XCTest
@testable import VaneKit

#if canImport(UIKit)
import UIKit
#endif

@MainActor
final class VaneThemeTests: XCTestCase {

    func test_theme_resolvesColorsForRequestedScheme() {
        let theme = makeTheme(
            lightAccent: .yellow,
            darkAccent: .orange
        )

        XCTAssertEqual(
            theme.color(.accent, for: .light),
            .yellow
        )

        XCTAssertEqual(
            theme.color(.accent, for: .dark),
            .orange
        )
    }

    func test_standardTheme_preservesExistingColors() {
        for scheme in [ColorScheme.light, .dark] {
            for role in VaneColorRole.allCases {
                XCTAssertEqual(
                    VaneTheme.standard.color(role, for: scheme),
                    VaneColor.color(role, for: scheme),
                    "Mismatch for \(role), \(scheme)"
                )
            }
        }
    }

    #if canImport(UIKit)

    func test_environment_inheritsParentTheme() async {
        let theme = makeTheme(
            lightAccent: .yellow,
            darkAccent: .orange
        )

        let appeared = expectation(
            description: "Child received parent theme"
        )

        let probe = ThemeProbe { resolvedTheme in
            XCTAssertEqual(
                resolvedTheme.color(.accent, for: .light),
                .yellow
            )
            appeared.fulfill()
        }

        let window = host(
            probe.vaneTheme(theme)
        )

        await fulfillment(of: [appeared], timeout: 3)
        window.isHidden = true
    }

    func test_environment_nestedThemeOverridesParent() async {
        let parent = makeTheme(
            lightAccent: .yellow,
            darkAccent: .orange
        )

        let child = makeTheme(
            lightAccent: .green,
            darkAccent: .mint
        )

        let appeared = expectation(
            description: "Nested themes resolved independently"
        )
        appeared.expectedFulfillmentCount = 2

        let view = VStack {
            ThemeProbe { theme in
                XCTAssertEqual(
                    theme.color(.accent, for: .light),
                    .yellow
                )
                appeared.fulfill()
            }

            ThemeProbe { theme in
                XCTAssertEqual(
                    theme.color(.accent, for: .light),
                    .green
                )
                appeared.fulfill()
            }
            .vaneTheme(child)
        }
        .vaneTheme(parent)

        let window = host(view)

        await fulfillment(of: [appeared], timeout: 3)
        window.isHidden = true
    }

    private func host<Content: View>(
        _ content: Content
    ) -> UIWindow {
        let controller = UIHostingController(
            rootView: content
        )

        let window = UIWindow(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 390,
                height: 844
            )
        )

        window.rootViewController = controller
        window.makeKeyAndVisible()

        return window
    }

    #endif

    private func makeTheme(
        lightAccent: Color,
        darkAccent: Color
    ) -> VaneTheme {
        VaneTheme(
            light: makePalette(accent: lightAccent),
            dark: makePalette(accent: darkAccent)
        )
    }

    private func makePalette(
        accent: Color
    ) -> VaneThemePalette {
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

#if canImport(UIKit)

@MainActor
private struct ThemeProbe: View {
    @Environment(\.vaneTheme) private var theme

    let capture: (VaneTheme) -> Void

    var body: some View {
        Color.clear
            .frame(width: 20, height: 20)
            .onAppear {
                capture(theme)
            }
    }
}

#endif
