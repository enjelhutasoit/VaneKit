//
// Copyright (c) 2026 Enjel Hutasoit
//

/// Semantic color roles. Components depend on roles, never on raw values.
public enum VaneColorRole: CaseIterable, Sendable {
    case background
    case surface
    case textPrimary
    case textSecondary
    case accent
    case onAccent
    case critical
    case onCritical
}
