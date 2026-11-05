//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

public struct VaneEmptyStateAction {
    let title: String
    let handler: @MainActor () -> Void

    public init(_ title: String, handler: @escaping @MainActor () -> Void) {
        self.title = title
        self.handler = handler
    }
}

/// Placeholder for screens without content. Pass already localized strings.
public struct VaneEmptyState: View {
    private let systemImage: String
    private let title: String
    private let message: String?
    private let action: VaneEmptyStateAction?

    public init(
        systemImage: String,
        title: String,
        message: String? = nil,
        action: VaneEmptyStateAction? = nil
    ) {
        self.systemImage = systemImage
        self.title = title
        self.message = message
        self.action = action
    }

    public var body: some View {
        VStack(spacing: VaneSpacing.lg) {
            VStack(spacing: VaneSpacing.xs) {
                Image(systemName: systemImage)
                    .font(VaneTextStyle.display.font)
                    .vaneForeground(.textSecondary)
                    .accessibilityHidden(true)
                Text(title)
                    .font(VaneTextStyle.headline.font)
                    .vaneForeground(.textPrimary)
                if let message = message.vaneTrimmedNonEmpty {
                    Text(message)
                        .font(VaneTextStyle.body.font)
                        .vaneForeground(.textSecondary)
                }
            }
            .accessibilityElement(children: .combine)

            if let action {
                Button(action.title, action: action.handler)
                    .buttonStyle(VaneButtonStyle(.primary))
            }
        }
        .multilineTextAlignment(.center)
        .padding(VaneSpacing.xl)
        .frame(maxWidth: .infinity)
    }
}
