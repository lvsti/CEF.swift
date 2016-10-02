//
//  CEFMainAxisAlignment.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies where along the main axis the CefBoxLayout child views should be
/// laid out.
public enum CEFMainAxisAlignment: Int32 {

    /// Child views will be left-aligned.
    case start

    /// Child views will be center-aligned.
    case center

    /// Child views will be right-aligned.
    case end
}

extension CEFMainAxisAlignment {
    static func fromCEF(value: cef_main_axis_alignment_t) -> CEFMainAxisAlignment {
        return CEFMainAxisAlignment(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_main_axis_alignment_t {
        return cef_main_axis_alignment_t(rawValue: UInt32(rawValue))
    }
}

