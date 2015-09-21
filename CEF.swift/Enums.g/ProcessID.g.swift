//
//  ProcessID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Existing process IDs.
public enum ProcessID: Int32 {

    /// Browser process.
    case Browser

    /// Renderer process.
    case Renderer
}

extension ProcessID {
    static func fromCEF(value: cef_process_id_t) -> ProcessID {
        return ProcessID(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_process_id_t {
        return cef_process_id_t(rawValue: UInt32(rawValue))
    }
}

