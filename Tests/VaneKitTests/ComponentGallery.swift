//
// Copyright (c) 2026 Enjel Hutasoit
//

#if os(iOS)
import SwiftUI
import VaneKit

/// Test-only view that renders every public component once.
struct ComponentGallery: View {
    let scheme: ColorScheme

    static let width: CGFloat = 390

    var body: some View {
        VStack(alignment: .leading, spacing: VaneSpacing.lg) {
            buttons
            badges
            fields
            card
            VaneEmptyState(
                systemImage: "tray",
                title: "No consultations",
                message: "Book your first consultation to see it here.",
                action: VaneEmptyStateAction("Book now") {}
            )
        }
        .padding(VaneSpacing.md)
        .frame(width: Self.width, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .background(VaneColor.color(.background, for: scheme))
    }

    private var buttons: some View {
        VStack(alignment: .leading, spacing: VaneSpacing.xs) {
            Button("Primary") {}.buttonStyle(VaneButtonStyle(.primary))
            Button("Secondary") {}.buttonStyle(VaneButtonStyle(.secondary))
            Button("Delete") {}.buttonStyle(VaneButtonStyle(.destructive))
            Button("Disabled") {}.buttonStyle(VaneButtonStyle(.primary)).disabled(true)
        }
    }

    private var badges: some View {
        VStack(alignment: .leading, spacing: VaneSpacing.xs) {
            VaneBadge("Neutral")
            VaneBadge("Active", kind: .accent)
            VaneBadge("Failed", kind: .critical)
        }
    }

    private var fields: some View {
        VStack(alignment: .leading, spacing: VaneSpacing.sm) {
            VaneTextField("Full name", text: .constant("Budi"), helper: "As shown on your ID")
            VaneTextField("Email", text: .constant("budi@"), error: "Enter a valid email")
        }
    }

    private var card: some View {
        VaneCard {
            VaneListRow("Dr. Contoh", subtitle: "General practitioner") {
                VaneBadge("Online", kind: .accent)
            }
            VaneListRow("Follow-up", subtitle: "Today, 10:00")
        }
    }
}
#endif
