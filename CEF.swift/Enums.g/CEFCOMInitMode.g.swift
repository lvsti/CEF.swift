//
//  CEFCOMInitMode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Windows COM initialization mode. Specifies how COM will be initialized for a
/// new thread.
/// CEF name: `cef_com_init_mode_t`.
public enum CEFCOMInitMode: Int32 {

    /// No COM initialization.
    /// CEF name: `COM_INIT_MODE_NONE`.
    case none

    /// Initialize COM using single-threaded apartments.
    /// CEF name: `COM_INIT_MODE_STA`.
    case sta

    /// Initialize COM using multi-threaded apartments.
    /// CEF name: `COM_INIT_MODE_MTA`.
    case mta
}

extension CEFCOMInitMode {
    static func fromCEF(_ value: cef_com_init_mode_t) -> CEFCOMInitMode {
        return CEFCOMInitMode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_com_init_mode_t {
        return cef_com_init_mode_t(rawValue: UInt32(rawValue))
    }
}

