//
//  CEFTextStyle.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Text style types. Should be kepy in sync with gfx::TextStyle.
public enum CEFTextStyle: Int32 {
    case bold
    case italic
    case strike
    case diagonalStrike
    case underline
}

extension CEFTextStyle {
    static func fromCEF(value: cef_text_style_t) -> CEFTextStyle {
        return CEFTextStyle(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_text_style_t {
        return cef_text_style_t(rawValue: UInt32(rawValue))
    }
}

