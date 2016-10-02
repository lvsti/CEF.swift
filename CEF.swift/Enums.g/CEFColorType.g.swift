//
//  CEFColorType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Describes how to interpret the components of a pixel.
public enum CEFColorType: Int32 {

    /// RGBA with 8 bits per pixel (32bits total).
    case rgba8888

    /// BGRA with 8 bits per pixel (32bits total).
    case bgra8888
}

extension CEFColorType {
    static func fromCEF(_ value: cef_color_type_t) -> CEFColorType {
        return CEFColorType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_color_type_t {
        return cef_color_type_t(rawValue: UInt32(rawValue))
    }
}

