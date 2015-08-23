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
    case Default

    /// Verbose logging.
    case Verbose

    /// INFO logging.
    case Info

    /// WARNING logging.
    case Warning

    /// ERROR logging.
    case Error

    /// Completely disable logging.
    case Disable = 99
}

extension CEFLogSeverity {
    static func fromCEF(value: cef_log_severity_t) -> CEFLogSeverity {
        return CEFLogSeverity(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_log_severity_t {
        return cef_log_severity_t(rawValue: UInt32(rawValue))
    }
}

