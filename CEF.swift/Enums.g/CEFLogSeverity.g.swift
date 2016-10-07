//
//  CEFLogSeverity.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Log severity levels.
/// CEF name: `cef_log_severity_t`.
public enum CEFLogSeverity: Int32 {

    /// Default logging (currently INFO logging).
    /// CEF name: `LOGSEVERITY_DEFAULT`.
    case defaultSeverity

    /// Verbose logging.
    /// CEF name: `LOGSEVERITY_VERBOSE`.
    case verbose

    /// INFO logging.
    /// CEF name: `LOGSEVERITY_INFO`.
    case info

    /// WARNING logging.
    /// CEF name: `LOGSEVERITY_WARNING`.
    case warning

    /// ERROR logging.
    /// CEF name: `LOGSEVERITY_ERROR`.
    case error

    /// Completely disable logging.
    /// CEF name: `LOGSEVERITY_DISABLE`.
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

