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
    case None = 0
    case Scale100Percent
    case Scale125Percent
    case Scale133Percent
    case Scale140Percent
    case Scale150Percent
    case Scale180Percent
    case Scale200Percent
    case Scale250Percent
    case Scale300Percent
}

extension CEFScaleFactor {
    static func fromCEF(value: cef_scale_factor_t) -> CEFScaleFactor {
        return CEFScaleFactor(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_scale_factor_t {
        return cef_scale_factor_t(rawValue: UInt32(rawValue))
    }
}

