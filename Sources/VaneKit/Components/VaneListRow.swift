//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// A row with a title, an optional subtitle and an optional trailing view.
/// It is not interactive; wrap it in `Button` or `NavigationLink`.
/// Pass already localized strings.
public struct VaneListRow<Trailing: View>: View {
    private let title: String
    private let subtitle: String?
    private let trailing: Trailing

    public init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .center, spacing: VaneSpacing.sm) {
            VStack(alignment: .leading, spacing: VaneSpacing.xxs) {
                Text(title)
                    .font(VaneTextStyle.body.font)
                    .vaneForeground(.textPrimary)
                if let subtitle = subtitle.vaneTrimmedNonEmpty {
                    Text(subtitle)
                        .font(VaneTextStyle.callout.font)
                        .vaneForeground(.textSecondary)
                }
            }
            Spacer(minLength: VaneSpacing.sm)
            trailing
        }
        .padding(.vertical, VaneSpacing.xs)
        .frame(minHeight: VaneSize.minimumTapTarget)
        .accessibilityElement(children: .combine)
    }
}

extension VaneListRow where Trailing == EmptyView {
    public init(_ title: String, subtitle: String? = nil) {
        self.init(title, subtitle: subtitle) { EmptyView() }
    }
}
