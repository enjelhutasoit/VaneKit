//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// A padded surface that groups related content.
public struct VaneCard<Content: View>: View {
    private static var colors: VaneComponentColors {
        VaneComponentColors(foreground: .textPrimary, background: .surface)
    }

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding(VaneSpacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .vaneColors(Self.colors, in: RoundedRectangle(cornerRadius: VaneRadius.lg))
    }
}
