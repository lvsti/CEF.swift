//
//  CEFShowState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Show states supported by CefWindowDelegate::GetInitialShowState.
/// CEF name: `cef_show_state_t`.
public enum CEFShowState: Int32 {
    /// CEF name: `CEF_SHOW_STATE_NORMAL`.
    case normal = 1
    /// CEF name: `CEF_SHOW_STATE_MINIMIZED`.
    case minimized
    /// CEF name: `CEF_SHOW_STATE_MAXIMIZED`.
    case maximized
    /// CEF name: `CEF_SHOW_STATE_FULLSCREEN`.
    case fullscreen
}

extension CEFShowState {
    static func fromCEF(_ value: cef_show_state_t) -> CEFShowState {
        return CEFShowState(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_show_state_t {
        return cef_show_state_t(rawValue: UInt32(rawValue))
    }
}

