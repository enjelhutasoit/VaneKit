//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

public enum VaneBadgeKind: CaseIterable, Sendable {
    case neutral
    case accent
    case critical

    var colors: VaneComponentColors {
        switch self {
        case .neutral:
            VaneComponentColors(foreground: .textSecondary, background: .surface, border: .textSecondary)
        case .accent:
            VaneComponentColors(foreground: .onAccent, background: .accent)
        case .critical:
            VaneComponentColors(foreground: .onCritical, background: .critical)
        }
    }
}

/// A short status label. Meaning is carried by the text, never by color alone.
/// Pass an already localized string.
public struct VaneBadge: View {
    private let text: String
    private let kind: VaneBadgeKind

    public init(_ text: String, kind: VaneBadgeKind = .neutral) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        Text(text)
            .font(VaneTextStyle.caption.font)
            .padding(.horizontal, VaneSpacing.xs)
            .padding(.vertical, VaneSpacing.xxs)
            .vaneColors(kind.colors, in: Capsule())
    }
}
