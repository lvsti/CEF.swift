//
//  FocusSource.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Focus sources.
public enum FocusSource: Int32 {

    /// The source is explicit navigation via the API (LoadURL(), etc).
    case Navigation = 0

    /// The source is a system-generated focus event.
    case System
}

extension FocusSource {
    static func fromCEF(value: cef_focus_source_t) -> FocusSource {
        return FocusSource(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_focus_source_t {
        return cef_focus_source_t(rawValue: UInt32(rawValue))
    }
}

