//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// A labeled text field with an optional helper or error message.
/// All strings must already be localized by the caller.
public struct VaneTextField: View {
    private let title: String

    @Binding private var text: String

    private let helper: String?
    private let error: String?

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.vaneTheme) private var theme

    @FocusState private var isFocused: Bool

    public init(
        _ title: String,
        text: Binding<String>,
        helper: String? = nil,
        error: String? = nil
    ) {
        self.title = title
        self._text = text
        self.helper = helper
        self.error = error
    }

    public var body: some View {
        let message = VaneFieldMessage.resolve(
            helper: helper,
            error: error
        )

        let shape = RoundedRectangle(
            cornerRadius: VaneRadius.md
        )

        VStack(
            alignment: .leading,
            spacing: VaneSpacing.xxs
        ) {
            Text(title)
                .font(VaneTextStyle.callout.font)
                .foregroundStyle(color(.textSecondary))
                .accessibilityHidden(true)

            TextField("", text: $text)
                .font(VaneTextStyle.body.font)
                .focused($isFocused)
                .padding(.horizontal, VaneSpacing.xs)
                .frame(
                    minHeight: VaneSize.minimumTapTarget
                )
                .foregroundStyle(color(.textPrimary))
                .background(
                    shape.fill(color(.surface))
                )
                .overlay {
                    shape.strokeBorder(
                        color(borderRole(for: message)),
                        lineWidth: isFocused
                            ? VaneSize.focusedBorderWidth
                            : VaneSize.borderWidth
                    )
                }
                .accessibilityLabel(title)
                .accessibilityHint(message?.text ?? "")

            if let message {
                messageRow(message)
            }
        }
    }

    private func messageRow(
        _ message: VaneFieldMessage
    ) -> some View {
        let role: VaneColorRole = message.kind == .error
            ? .critical
            : .textSecondary

        return HStack(
            alignment: .firstTextBaseline,
            spacing: VaneSpacing.xxs
        ) {
            if message.kind == .error {
                Image(
                    systemName: "exclamationmark.circle.fill"
                )
            }

            Text(message.text)
        }
        .font(VaneTextStyle.caption.font)
        .foregroundStyle(color(role))
        .accessibilityHidden(true)
    }

    private func borderRole(
        for message: VaneFieldMessage?
    ) -> VaneColorRole {
        if message?.kind == .error {
            return .critical
        }

        return isFocused ? .accent : .textSecondary
    }

    private func color(
        _ role: VaneColorRole
    ) -> Color {
        theme.color(role, for: colorScheme)
    }
}
