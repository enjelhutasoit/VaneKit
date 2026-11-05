//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

struct VaneColoredBackground<S: InsettableShape>: ViewModifier {
    let colors: VaneComponentColors
    let shape: S

    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundStyle(VaneColor.color(colors.foreground, for: colorScheme))
            .background(shape.fill(VaneColor.color(colors.background, for: colorScheme)))
            .overlay {
                if let border = colors.border {
                    shape.strokeBorder(
                        VaneColor.color(border, for: colorScheme),
                        lineWidth: VaneSize.borderWidth
                    )
                }
            }
    }
}

extension View {
    func vaneColors<S: InsettableShape>(_ colors: VaneComponentColors, in shape: S) -> some View {
        modifier(VaneColoredBackground(colors: colors, shape: shape))
    }
}
