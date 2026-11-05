//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// Visual variants of ``VaneButtonStyle``.
public enum VaneButtonKind: CaseIterable, Sendable {
    case primary
    case secondary
    case destructive

    var colors: VaneComponentColors {
        switch self {
        case .primary:
            VaneComponentColors(foreground: .onAccent, background: .accent)
        case .secondary:
            VaneComponentColors(foreground: .accent, background: .surface, border: .accent)
        case .destructive:
            VaneComponentColors(foreground: .onCritical, background: .critical)
        }
    }
}

/// A button style. Use with the standard `Button` to keep system semantics:
/// `Button("Save", action: save).buttonStyle(VaneButtonStyle(.primary))`.
public struct VaneButtonStyle: ButtonStyle {
    private let kind: VaneButtonKind

    public init(_ kind: VaneButtonKind = .primary) {
        self.kind = kind
    }

    public func makeBody(configuration: Configuration) -> some View {
        VaneButtonBody(kind: kind, configuration: configuration)
    }
}

private struct VaneButtonBody: View {
    let kind: VaneButtonKind
    let configuration: ButtonStyleConfiguration

    @Environment(\.isEnabled) private var isEnabled

    private enum Opacity {
        static let pressed = 0.8
        static let disabled = 0.4
    }

    private var opacity: Double {
        guard isEnabled else { return Opacity.disabled }
        return configuration.isPressed ? Opacity.pressed : 1
    }

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: VaneRadius.md)
        configuration.label
            .font(VaneTextStyle.headline.font)
            .padding(.horizontal, VaneSpacing.xs)
            .frame(minWidth: VaneSize.minimumTapTarget, minHeight: VaneSize.minimumTapTarget)
            .vaneColors(kind.colors, in: shape)
            .contentShape(shape)
            .opacity(opacity)
    }
}
