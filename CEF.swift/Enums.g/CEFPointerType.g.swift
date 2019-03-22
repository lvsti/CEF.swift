//
//  CEFPointerType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// The device type that caused the event.
/// CEF name: `cef_pointer_type_t`.
public enum CEFPointerType: Int32 {
    /// CEF name: `CEF_POINTER_TYPE_TOUCH`.
    case touch = 0
    /// CEF name: `CEF_POINTER_TYPE_MOUSE`.
    case mouse
    /// CEF name: `CEF_POINTER_TYPE_PEN`.
    case pen
    /// CEF name: `CEF_POINTER_TYPE_ERASER`.
    case eraser
    /// CEF name: `CEF_POINTER_TYPE_UNKNOWN`.
    case unknown
}

extension CEFPointerType {
    static func fromCEF(_ value: cef_pointer_type_t) -> CEFPointerType {
        return CEFPointerType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_pointer_type_t {
        return cef_pointer_type_t(rawValue: UInt32(rawValue))
    }
}

