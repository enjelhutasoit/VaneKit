//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

struct VaneForeground: ViewModifier {
    let role: VaneColorRole

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.vaneTheme) private var theme

    func body(content: Content) -> some View {
        content.foregroundStyle(
            theme.color(
                role,
                for: colorScheme
            )
        )
    }
}

extension View {
    func vaneForeground(
        _ role: VaneColorRole
    ) -> some View {
        modifier(
            VaneForeground(role: role)
        )
    }
}
