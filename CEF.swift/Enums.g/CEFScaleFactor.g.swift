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
/// CEF name: `cef_scale_factor_t`.
public enum CEFScaleFactor: Int32 {
    /// CEF name: `SCALE_FACTOR_NONE`.
    case none = 0
    /// CEF name: `SCALE_FACTOR_100P`.
    case scale100Percent
    /// CEF name: `SCALE_FACTOR_125P`.
    case scale125Percent
    /// CEF name: `SCALE_FACTOR_133P`.
    case scale133Percent
    /// CEF name: `SCALE_FACTOR_140P`.
    case scale140Percent
    /// CEF name: `SCALE_FACTOR_150P`.
    case scale150Percent
    /// CEF name: `SCALE_FACTOR_180P`.
    case scale180Percent
    /// CEF name: `SCALE_FACTOR_200P`.
    case scale200Percent
    /// CEF name: `SCALE_FACTOR_250P`.
    case scale250Percent
    /// CEF name: `SCALE_FACTOR_300P`.
    case scale300Percent
}

extension CEFScaleFactor {
    static func fromCEF(_ value: cef_scale_factor_t) -> CEFScaleFactor {
        return CEFScaleFactor(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_scale_factor_t {
        return cef_scale_factor_t(rawValue: UInt32(rawValue))
    }
}

