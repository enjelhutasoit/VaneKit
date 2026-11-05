//
// Copyright (c) 2026 Enjel Hutasoit
//

import Foundation

/// The single message shown under a field. An error wins over a helper.
/// Blank or whitespace-only input counts as absent.
struct VaneFieldMessage: Equatable, Sendable {
    enum Kind: Equatable, Sendable {
        case helper
        case error
    }

    let kind: Kind
    let text: String

    static func resolve(helper: String?, error: String?) -> VaneFieldMessage? {
        if let text = trimmedNonEmpty(error) {
            return VaneFieldMessage(kind: .error, text: text)
        }
        if let text = trimmedNonEmpty(helper) {
            return VaneFieldMessage(kind: .helper, text: text)
        }
        return nil
    }

    private static func trimmedNonEmpty(_ value: String?) -> String? {
        guard let trimmed = value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !trimmed.isEmpty else { return nil }
        return trimmed
    }
}
