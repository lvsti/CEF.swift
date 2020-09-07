//
//  CEFCookiePriority.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Cookie priority values.
/// CEF name: `cef_cookie_priority_t`.
public enum CEFCookiePriority: Int32 {
    /// CEF name: `CEF_COOKIE_PRIORITY_LOW`.
    case low = -1
    /// CEF name: `CEF_COOKIE_PRIORITY_MEDIUM`.
    case medium = 0
    /// CEF name: `CEF_COOKIE_PRIORITY_HIGH`.
    case high = 1
}

extension CEFCookiePriority {
    static func fromCEF(_ value: cef_cookie_priority_t) -> CEFCookiePriority {
        return CEFCookiePriority(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cookie_priority_t {
        return cef_cookie_priority_t(rawValue: Int32(rawValue))
    }
}

