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
    case Left

    /// Align the text's center with that of its display area.
    case Center

    /// Align the text's right edge with that of its display area.
    case Right
}

extension CEFHorizontalAlignment {
    static func fromCEF(value: cef_horizontal_alignment_t) -> CEFHorizontalAlignment {
        return CEFHorizontalAlignment(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_horizontal_alignment_t {
        return cef_horizontal_alignment_t(rawValue: UInt32(rawValue))
    }
}

