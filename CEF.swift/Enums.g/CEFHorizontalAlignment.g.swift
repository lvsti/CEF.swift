//
//  CEFHorizontalAlignment.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies the horizontal text alignment mode.
public enum CEFHorizontalAlignment: Int32 {

    /// Align the text's left edge with that of its display area.
    case left

    /// Align the text's center with that of its display area.
    case center

    /// Align the text's right edge with that of its display area.
    case right
}

extension CEFHorizontalAlignment {
    static func fromCEF(_ value: cef_horizontal_alignment_t) -> CEFHorizontalAlignment {
        return CEFHorizontalAlignment(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_horizontal_alignment_t {
        return cef_horizontal_alignment_t(rawValue: UInt32(rawValue))
    }
}

