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
    @FocusState private var isFocused: Bool

    public init(_ title: String, text: Binding<String>, helper: String? = nil, error: String? = nil) {
        self.title = title
        self._text = text
        self.helper = helper
        self.error = error
    }

    public var body: some View {
        let message = VaneFieldMessage.resolve(helper: helper, error: error)
        let shape = RoundedRectangle(cornerRadius: VaneRadius.md)

        VStack(alignment: .leading, spacing: VaneSpacing.xxs) {
            Text(title)
                .font(VaneTextStyle.callout.font)
                .foregroundStyle(VaneColor.color(.textSecondary, for: colorScheme))
                .accessibilityHidden(true)

            TextField("", text: $text)
                .font(VaneTextStyle.body.font)
                .focused($isFocused)
                .padding(.horizontal, VaneSpacing.sm)
                .frame(minHeight: VaneSize.minimumTapTarget)
                .foregroundStyle(VaneColor.color(.textPrimary, for: colorScheme))
                .background(shape.fill(VaneColor.color(.surface, for: colorScheme)))
                .overlay {
                    shape.strokeBorder(
                        VaneColor.color(borderRole(for: message), for: colorScheme),
                        lineWidth: isFocused ? VaneSize.focusedBorderWidth : VaneSize.borderWidth
                    )
                }
                .accessibilityLabel(title)
                .accessibilityHint(message?.text ?? "")

            if let message {
                messageRow(message)
            }
        }
    }

    private func messageRow(_ message: VaneFieldMessage) -> some View {
        let role: VaneColorRole = message.kind == .error ? .critical : .textSecondary
        return HStack(alignment: .firstTextBaseline, spacing: VaneSpacing.xxs) {
            if message.kind == .error {
                Image(systemName: "exclamationmark.circle.fill")
            }
            Text(message.text)
        }
        .font(VaneTextStyle.caption.font)
        .foregroundStyle(VaneColor.color(role, for: colorScheme))
        .accessibilityHidden(true)
    }

    private func borderRole(for message: VaneFieldMessage?) -> VaneColorRole {
        if message?.kind == .error { return .critical }
        return isFocused ? .accent : .textSecondary
    }
}
