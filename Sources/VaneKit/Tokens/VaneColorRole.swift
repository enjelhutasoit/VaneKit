//
// Copyright (c) 2026 Enjel Hutasoit
//

/// Semantic color roles. Components depend on roles, never on raw values.
///
/// Resolve a role to a `Color` with ``VaneColor/color(_:for:)``.
public enum VaneColorRole: CaseIterable, Sendable {
    /// The screen background.
    case background
    /// Elevated content such as cards and fields.
    case surface
    /// Primary text on `background` and `surface`.
    case textPrimary
    /// Secondary text on `background` and `surface`.
    case textSecondary
    /// Brand and interactive emphasis.
    case accent
    /// Content drawn on top of `accent`.
    case onAccent
    /// Errors and destructive actions.
    case critical
    /// Content drawn on top of `critical`.
    case onCritical
}
