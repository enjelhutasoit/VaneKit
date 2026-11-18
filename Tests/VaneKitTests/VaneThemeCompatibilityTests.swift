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
final class VaneThemeCompatibilityTests: XCTestCase {

    // MARK: - Custom Palette Resolution

    func test_customTheme_resolvesEveryRoleInLightMode() {
        let theme = makeTheme()

        assertRoles(
            [
                (.background, .white),
                (.surface, .gray),
                (.textPrimary, .black),
                (.textSecondary, .brown),
                (.accent, .yellow),
                (.onAccent, .black),
                (.critical, .red),
                (.onCritical, .white)
            ],
            in: theme,
            scheme: .light
        )
    }

    func test_customTheme_resolvesEveryRoleInDarkMode() {
        let theme = makeTheme()

        assertRoles(
            [
                (.background, .black),
                (.surface, .brown),
                (.textPrimary, .white),
                (.textSecondary, .gray),
                (.accent, .orange),
                (.onAccent, .black),
                (.critical, .pink),
                (.onCritical, .white)
            ],
            in: theme,
            scheme: .dark
        )
    }

    // MARK: - Backward Compatibility

    #if canImport(UIKit)

    func test_components_withoutTheme_matchStandardTheme() {
        let components: [(String, AnyView)] = [
            (
                "PrimaryButton",
                AnyView(
                    Button("Continue") {}
                        .buttonStyle(VaneButtonStyle(.primary))
                )
            ),
            (
                "SecondaryButton",
                AnyView(
                    Button("Cancel") {}
                        .buttonStyle(VaneButtonStyle(.secondary))
                )
            ),
            (
                "DestructiveButton",
                AnyView(
                    Button("Delete") {}
                        .buttonStyle(VaneButtonStyle(.destructive))
                )
            ),
            (
                "AccentBadge",
                AnyView(
                    VaneBadge("Premium", kind: .accent)
                )
            ),
            (
                "NeutralBadge",
                AnyView(
                    VaneBadge("Active", kind: .neutral)
                )
            ),
            (
                "CriticalBadge",
                AnyView(
                    VaneBadge("Failed", kind: .critical)
                )
            ),
            (
                "Card",
                AnyView(
                    VaneCard {
                        Text("Balance")
                    }
                )
            ),
            (
                "ListRow",
                AnyView(
                    VaneListRow(
                        "Account",
                        subtitle: "Savings"
                    )
                )
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

        for scheme in [ColorScheme.light, .dark] {
            for (name, component) in components {
                let implicit = render(
                    component
                        .environment(\.colorScheme, scheme)
                )

                let explicit = render(
                    component
                        .vaneTheme(.standard)
                        .environment(\.colorScheme, scheme)
                )

                XCTAssertEqual(
                    implicit.pngData(),
                    explicit.pngData(),
                    "\(name) changed in \(scheme) mode"
                )
            }
        }
    }

    #endif

    // MARK: - Fixtures

    private func makeTheme() -> VaneTheme {
        VaneTheme(
            light: VaneThemePalette(
                background: .white,
                surface: .gray,
                textPrimary: .black,
                textSecondary: .brown,
                accent: .yellow,
                onAccent: .black,
                critical: .red,
                onCritical: .white
            ),
            dark: VaneThemePalette(
                background: .black,
                surface: .brown,
                textPrimary: .white,
                textSecondary: .gray,
                accent: .orange,
                onAccent: .black,
                critical: .pink,
                onCritical: .white
            )
        )
    }

    private func assertRoles(
        _ expected: [(VaneColorRole, Color)],
        in theme: VaneTheme,
        scheme: ColorScheme,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for (role, expectedColor) in expected {
            XCTAssertEqual(
                theme.color(role, for: scheme),
                expectedColor,
                "Incorrect \(role) in \(scheme)",
                file: file,
                line: line
            )
        }
    }

    #if canImport(UIKit)

    private func render<Content: View>(
        _ content: Content
    ) -> UIImage {
        let view = content
            .frame(width: 320, height: 180)
            .background(Color.white)

        let renderer = ImageRenderer(content: view)
        renderer.scale = 1

        guard let image = renderer.uiImage else {
            XCTFail("ImageRenderer returned nil")
            return UIImage()
        }

        return image
    }

    #endif
}
