//
//  CEFButtonState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies the button display state.
/// CEF name: `cef_button_state_t`.
public enum CEFButtonState: Int32 {
    /// CEF name: `CEF_BUTTON_STATE_NORMAL`.
    case normal
    /// CEF name: `CEF_BUTTON_STATE_HOVERED`.
    case hovered
    /// CEF name: `CEF_BUTTON_STATE_PRESSED`.
    case pressed
    /// CEF name: `CEF_BUTTON_STATE_DISABLED`.
    case disabled
}

extension CEFButtonState {
    static func fromCEF(_ value: cef_button_state_t) -> CEFButtonState {
        return CEFButtonState(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_button_state_t {
        return cef_button_state_t(rawValue: UInt32(rawValue))
    }
}

