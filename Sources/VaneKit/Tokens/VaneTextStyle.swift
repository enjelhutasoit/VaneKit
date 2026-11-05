//
// Copyright (c) 2026 Enjel Hutasoit
//

import SwiftUI

/// Typography roles mapped to system text styles so Dynamic Type applies.
/// No fixed point sizes are exposed on purpose.
public enum VaneTextStyle: CaseIterable, Sendable {
    case display
    case title
    case headline
    case body
    case callout
    case caption

    public var font: Font {
        Font.system(textStyle, design: .default, weight: weight)
    }

    private var textStyle: Font.TextStyle {
        switch self {
        case .display: .largeTitle
        case .title: .title2
        case .headline: .headline
        case .body: .body
        case .callout: .callout
        case .caption: .caption
        }
    }

    private var weight: Font.Weight {
        switch self {
        case .display: .bold
        case .title, .headline: .semibold
        case .body, .callout, .caption: .regular
        }
    }
}
