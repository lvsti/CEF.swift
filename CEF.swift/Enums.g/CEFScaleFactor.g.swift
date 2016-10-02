//
//  CEFScaleFactor.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported UI scale factors for the platform. SCALE_FACTOR_NONE is used for
/// density independent resources such as string, html/js files or an image that
/// can be used for any scale factors (such as wallpapers).
public enum CEFScaleFactor: Int32 {
    case none = 0
    case scale100Percent
    case scale125Percent
    case scale133Percent
    case scale140Percent
    case scale150Percent
    case scale180Percent
    case scale200Percent
    case scale250Percent
    case scale300Percent
}

extension CEFScaleFactor {
    static func fromCEF(value: cef_scale_factor_t) -> CEFScaleFactor {
        return CEFScaleFactor(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_scale_factor_t {
        return cef_scale_factor_t(rawValue: UInt32(rawValue))
    }
}

