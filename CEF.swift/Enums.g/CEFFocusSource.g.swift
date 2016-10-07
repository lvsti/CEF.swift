//
//  CEFFocusSource.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Focus sources.
/// CEF name: `cef_focus_source_t`.
public enum CEFFocusSource: Int32 {

    /// The source is explicit navigation via the API (LoadURL(), etc).
    /// CEF name: `FOCUS_SOURCE_NAVIGATION`.
    case navigation = 0

    /// The source is a system-generated focus event.
    /// CEF name: `FOCUS_SOURCE_SYSTEM`.
    case system
}

extension CEFFocusSource {
    static func fromCEF(_ value: cef_focus_source_t) -> CEFFocusSource {
        return CEFFocusSource(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_focus_source_t {
        return cef_focus_source_t(rawValue: UInt32(rawValue))
    }
}

