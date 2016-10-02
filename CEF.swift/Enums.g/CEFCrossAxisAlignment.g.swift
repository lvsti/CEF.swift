//
//  CEFCrossAxisAlignment.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies where along the cross axis the CefBoxLayout child views should be
/// laid out.
public enum CEFCrossAxisAlignment: Int32 {

    /// Child views will be stretched to fit.
    case stretch

    /// Child views will be left-aligned.
    case start

    /// Child views will be center-aligned.
    case center

    /// Child views will be right-aligned.
    case end
}

extension CEFCrossAxisAlignment {
    static func fromCEF(value: cef_cross_axis_alignment_t) -> CEFCrossAxisAlignment {
        return CEFCrossAxisAlignment(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cross_axis_alignment_t {
        return cef_cross_axis_alignment_t(rawValue: UInt32(rawValue))
    }
}

