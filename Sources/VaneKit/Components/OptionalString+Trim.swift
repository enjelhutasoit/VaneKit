//
// Copyright (c) 2026 Enjel Hutasoit
//

import Foundation

extension Optional where Wrapped == String {
    /// The string trimmed of surrounding whitespace and newlines, or `nil`
    /// when it is absent or blank.
    var vaneTrimmedNonEmpty: String? {
        guard let trimmed = self?.trimmingCharacters(in: .whitespacesAndNewlines),
              !trimmed.isEmpty else { return nil }
        return trimmed
    }
}
