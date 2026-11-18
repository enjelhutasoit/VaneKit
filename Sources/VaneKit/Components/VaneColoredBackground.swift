//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

struct VaneColoredBackground<S: InsettableShape>: ViewModifier {
    let colors: VaneComponentColors
    let shape: S

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.vaneTheme) private var theme

    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                theme.color(
                    colors.foreground,
                    for: colorScheme
                )
            )
            .background(
                shape.fill(
                    theme.color(
                        colors.background,
                        for: colorScheme
                    )
                )
            )
            .overlay {
                if let border = colors.border {
                    shape.strokeBorder(
                        theme.color(
                            border,
                            for: colorScheme
                        ),
                        lineWidth: VaneSize.borderWidth
                    )
                }
            }
    }
}

extension View {
    func vaneColors<S: InsettableShape>(
        _ colors: VaneComponentColors,
        in shape: S
    ) -> some View {
        modifier(
            VaneColoredBackground(
                colors: colors,
                shape: shape
            )
        )
    }
}
