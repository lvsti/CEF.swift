//
//  CEFState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Represents the state of a setting.
public enum CEFState: Int32 {

    /// Use the default state for the setting.
    case Default = 0

    /// Enable or allow the setting.
    case Enabled

    /// Disable or disallow the setting.
    case Disabled
}

extension CEFState {
    static func fromCEF(value: cef_state_t) -> CEFState {
        return CEFState(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_state_t {
        return cef_state_t(rawValue: UInt32(rawValue))
    }
}

