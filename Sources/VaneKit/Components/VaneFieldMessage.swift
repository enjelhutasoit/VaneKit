//
// Copyright (c) 2026 Enjel Hutasoit
//

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
        if let text = error.vaneTrimmedNonEmpty {
            return VaneFieldMessage(kind: .error, text: text)
        }
        if let text = helper.vaneTrimmedNonEmpty {
            return VaneFieldMessage(kind: .helper, text: text)
        }
        return nil
    }
}
