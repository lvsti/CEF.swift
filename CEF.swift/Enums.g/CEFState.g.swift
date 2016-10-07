//
//  CEFState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Represents the state of a setting.
/// CEF name: `cef_state_t`.
public enum CEFState: Int32 {

    /// Use the default state for the setting.
    /// CEF name: `STATE_DEFAULT`.
    case defaultState = 0

    /// Enable or allow the setting.
    /// CEF name: `STATE_ENABLED`.
    case enabled

    /// Disable or disallow the setting.
    /// CEF name: `STATE_DISABLED`.
    case disabled
}

extension CEFState {
    static func fromCEF(_ value: cef_state_t) -> CEFState {
        return CEFState(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_state_t {
        return cef_state_t(rawValue: UInt32(rawValue))
    }
}

