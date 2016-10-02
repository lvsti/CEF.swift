//
//  CEFNavigationType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Navigation types.
public enum CEFNavigationType: Int32 {
    case linkClicked = 0
    case formSubmitted
    case backForward
    case reload
    case formResubmitted
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

