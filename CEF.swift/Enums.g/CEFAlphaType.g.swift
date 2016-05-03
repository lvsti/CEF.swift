//
//  CEFAlphaType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Describes how to interpret the alpha component of a pixel.
public enum CEFAlphaType: Int32 {

    /// No transparency. The alpha component is ignored.
    case Opaque

    /// Transparency with pre-multiplied alpha component.
    case Premultiplied

    /// Transparency with post-multiplied alpha component.
    case Postmultiplied
}

extension CEFAlphaType {
    static func fromCEF(value: cef_alpha_type_t) -> CEFAlphaType {
        return CEFAlphaType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_alpha_type_t {
        return cef_alpha_type_t(rawValue: UInt32(rawValue))
    }
}

