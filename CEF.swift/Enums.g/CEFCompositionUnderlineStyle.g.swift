//
//  CEFCompositionUnderlineStyle.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Composition underline style.
/// CEF name: `cef_composition_underline_style_t`.
public enum CEFCompositionUnderlineStyle: Int32 {
    /// CEF name: `CEF_CUS_SOLID`.
    case solid
    /// CEF name: `CEF_CUS_DOT`.
    case dot
    /// CEF name: `CEF_CUS_DASH`.
    case dash
    /// CEF name: `CEF_CUS_NONE`.
    case none
}

extension CEFCompositionUnderlineStyle {
    static func fromCEF(_ value: cef_composition_underline_style_t) -> CEFCompositionUnderlineStyle {
        return CEFCompositionUnderlineStyle(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_composition_underline_style_t {
        return cef_composition_underline_style_t(rawValue: UInt32(rawValue))
    }
}

