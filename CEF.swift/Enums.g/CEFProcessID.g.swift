//
//  CEFProcessID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Existing process IDs.
/// CEF name: `cef_process_id_t`.
public enum CEFProcessID: Int32 {

    /// Browser process.
    /// CEF name: `PID_BROWSER`.
    case browser

    /// Renderer process.
    /// CEF name: `PID_RENDERER`.
    case renderer
}

extension CEFProcessID {
    static func fromCEF(_ value: cef_process_id_t) -> CEFProcessID {
        return CEFProcessID(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_process_id_t {
        return cef_process_id_t(rawValue: UInt32(rawValue))
    }
}

