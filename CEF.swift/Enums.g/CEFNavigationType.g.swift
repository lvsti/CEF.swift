//
//  CEFNavigationType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Navigation types.
/// CEF name: `cef_navigation_type_t`.
public enum CEFNavigationType: Int32 {
    /// CEF name: `NAVIGATION_LINK_CLICKED`.
    case linkClicked = 0
    /// CEF name: `NAVIGATION_FORM_SUBMITTED`.
    case formSubmitted
    /// CEF name: `NAVIGATION_BACK_FORWARD`.
    case backForward
    /// CEF name: `NAVIGATION_RELOAD`.
    case reload
    /// CEF name: `NAVIGATION_FORM_RESUBMITTED`.
    case formResubmitted
    /// CEF name: `NAVIGATION_OTHER`.
    case other
}

extension CEFNavigationType {
    static func fromCEF(_ value: cef_navigation_type_t) -> CEFNavigationType {
        return CEFNavigationType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_navigation_type_t {
        return cef_navigation_type_t(rawValue: UInt32(rawValue))
    }
}

