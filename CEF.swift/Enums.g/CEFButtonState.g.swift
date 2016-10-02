//
//  CEFButtonState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies the button display state.
public enum CEFButtonState: Int32 {
    case normal
    case hovered
    case pressed
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

