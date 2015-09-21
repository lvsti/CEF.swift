//
//  LogSeverity.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Log severity levels.
public enum LogSeverity: Int32 {

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

extension LogSeverity {
    static func fromCEF(value: cef_log_severity_t) -> LogSeverity {
        return LogSeverity(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_log_severity_t {
        return cef_log_severity_t(rawValue: UInt32(rawValue))
    }
}

