//
//  CEFDuplexMode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Print job duplex mode values.
/// CEF name: `cef_duplex_mode_t`.
public enum CEFDuplexMode: Int32 {
    /// CEF name: `DUPLEX_MODE_UNKNOWN`.
    case unknown = -1
    /// CEF name: `DUPLEX_MODE_SIMPLEX`.
    case simplex
    /// CEF name: `DUPLEX_MODE_LONG_EDGE`.
    case longEdge
    /// CEF name: `DUPLEX_MODE_SHORT_EDGE`.
    case shortEdge
}

extension CEFDuplexMode {
    static func fromCEF(_ value: cef_duplex_mode_t) -> CEFDuplexMode {
        return CEFDuplexMode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_duplex_mode_t {
        return cef_duplex_mode_t(rawValue: Int32(rawValue))
    }
}

