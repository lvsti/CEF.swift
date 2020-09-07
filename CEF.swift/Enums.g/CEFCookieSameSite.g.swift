//
//  CEFCookieSameSite.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Cookie same site values.
/// CEF name: `cef_cookie_same_site_t`.
public enum CEFCookieSameSite: Int32 {
    /// CEF name: `CEF_COOKIE_SAME_SITE_UNSPECIFIED`.
    case unspecified
    /// CEF name: `CEF_COOKIE_SAME_SITE_NO_RESTRICTION`.
    case noRestriction
    /// CEF name: `CEF_COOKIE_SAME_SITE_LAX_MODE`.
    case laxMode
    /// CEF name: `CEF_COOKIE_SAME_SITE_STRICT_MODE`.
    case strictMode
}

extension CEFCookieSameSite {
    static func fromCEF(_ value: cef_cookie_same_site_t) -> CEFCookieSameSite {
        return CEFCookieSameSite(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cookie_same_site_t {
        return cef_cookie_same_site_t(rawValue: UInt32(rawValue))
    }
}

