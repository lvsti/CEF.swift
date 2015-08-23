//
//  CEFPaintElementType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Paint element types.
public enum CEFPaintElementType: Int32 {
    case View = 0
    case Popup
}

extension CEFPaintElementType {
    static func fromCEF(value: cef_paint_element_type_t) -> CEFPaintElementType {
        return CEFPaintElementType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_paint_element_type_t {
        return cef_paint_element_type_t(rawValue: UInt32(rawValue))
    }
}

