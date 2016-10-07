//
//  CEFTextStyle.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Text style types. Should be kepy in sync with gfx::TextStyle.
/// CEF name: `cef_text_style_t`.
public enum CEFTextStyle: Int32 {
    /// CEF name: `CEF_TEXT_STYLE_BOLD`.
    case bold
    /// CEF name: `CEF_TEXT_STYLE_ITALIC`.
    case italic
    /// CEF name: `CEF_TEXT_STYLE_STRIKE`.
    case strike
    /// CEF name: `CEF_TEXT_STYLE_DIAGONAL_STRIKE`.
    case diagonalStrike
    /// CEF name: `CEF_TEXT_STYLE_UNDERLINE`.
    case underline
}

extension CEFTextStyle {
    static func fromCEF(_ value: cef_text_style_t) -> CEFTextStyle {
        return CEFTextStyle(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_text_style_t {
        return cef_text_style_t(rawValue: UInt32(rawValue))
    }
}

