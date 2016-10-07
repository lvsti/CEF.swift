//
//  CEFPaintElementType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Paint element types.
/// CEF name: `cef_paint_element_type_t`.
public enum CEFPaintElementType: Int32 {
    /// CEF name: `PET_VIEW`.
    case view = 0
    /// CEF name: `PET_POPUP`.
    case popup
}

extension CEFPaintElementType {
    static func fromCEF(_ value: cef_paint_element_type_t) -> CEFPaintElementType {
        return CEFPaintElementType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_paint_element_type_t {
        return cef_paint_element_type_t(rawValue: UInt32(rawValue))
    }
}

