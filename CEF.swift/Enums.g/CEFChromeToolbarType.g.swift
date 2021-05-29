//
//  CEFChromeToolbarType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported Chrome toolbar types.
/// CEF name: `cef_chrome_toolbar_type_t`.
public enum CEFChromeToolbarType: Int32 {
    /// CEF name: `CEF_CTT_NONE`.
    case none = 1
    /// CEF name: `CEF_CTT_NORMAL`.
    case normal
    /// CEF name: `CEF_CTT_LOCATION`.
    case location
}

extension CEFChromeToolbarType {
    static func fromCEF(_ value: cef_chrome_toolbar_type_t) -> CEFChromeToolbarType {
        return CEFChromeToolbarType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_chrome_toolbar_type_t {
        return cef_chrome_toolbar_type_t(rawValue: UInt32(rawValue))
    }
}

