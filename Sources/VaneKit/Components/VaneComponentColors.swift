//
// Copyright (c) 2026 Enjel Hutasoit
//

/// Color roles a component uses. Kept as data so contrast can be tested.
struct VaneComponentColors: Equatable, Sendable {
    let foreground: VaneColorRole
    let background: VaneColorRole
    let border: VaneColorRole?

    init(foreground: VaneColorRole, background: VaneColorRole, border: VaneColorRole? = nil) {
        self.foreground = foreground
        self.background = background
        self.border = border
    }
}
