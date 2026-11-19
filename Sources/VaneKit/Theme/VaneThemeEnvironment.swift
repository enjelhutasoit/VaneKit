//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

private struct VaneThemeKey: EnvironmentKey {
    static var defaultValue: VaneTheme {
        .standard
    }
}

public extension EnvironmentValues {

    /// The active VaneKit theme.
    var vaneTheme: VaneTheme {
        get {
            self[VaneThemeKey.self]
        }
        set {
            self[VaneThemeKey.self] = newValue
        }
    }
}

public extension View {

    /// Applies a VaneKit theme to this view hierarchy.
    ///
    /// Descendant views inherit the theme unless
    /// a nested view provides another theme.
    func vaneTheme(
        _ theme: VaneTheme
    ) -> some View {
        environment(\.vaneTheme, theme)
    }
}
