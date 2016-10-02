//
//  CEFLogSeverity.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Log severity levels.
public enum CEFLogSeverity: Int32 {

    /// Default logging (currently INFO logging).
    case defaultSeverity

    /// Verbose logging.
    case verbose

    /// INFO logging.
    case info

    /// WARNING logging.
    case warning

    /// ERROR logging.
    case error

    /// Completely disable logging.
    case disable = 99
}

extension CEFLogSeverity {
    static func fromCEF(_ value: cef_log_severity_t) -> CEFLogSeverity {
        return CEFLogSeverity(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_log_severity_t {
        return cef_log_severity_t(rawValue: UInt32(rawValue))
    }
}

