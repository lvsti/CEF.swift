//
//  PaintElementType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Paint element types.
public enum PaintElementType: Int32 {
    case View = 0
    case Popup
}

extension PaintElementType {
    static func fromCEF(value: cef_paint_element_type_t) -> PaintElementType {
        return PaintElementType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_paint_element_type_t {
        return cef_paint_element_type_t(rawValue: UInt32(rawValue))
    }
}

