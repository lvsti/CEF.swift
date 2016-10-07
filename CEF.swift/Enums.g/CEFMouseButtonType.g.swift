//
//  CEFMouseButtonType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Mouse button types.
/// CEF name: `cef_mouse_button_type_t`.
public enum CEFMouseButtonType: Int32 {
    /// CEF name: `MBT_LEFT`.
    case left = 0
    /// CEF name: `MBT_MIDDLE`.
    case middle
    /// CEF name: `MBT_RIGHT`.
    case right
}

extension CEFMouseButtonType {
    static func fromCEF(_ value: cef_mouse_button_type_t) -> CEFMouseButtonType {
        return CEFMouseButtonType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_mouse_button_type_t {
        return cef_mouse_button_type_t(rawValue: UInt32(rawValue))
    }
}

