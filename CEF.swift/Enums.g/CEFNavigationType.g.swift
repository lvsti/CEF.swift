//
//  CEFNavigationType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Navigation types.
///
public enum CEFNavigationType: Int32 {
    case LinkClicked = 0
    case FormSubmitted
    case BackForward
    case Reload
    case FormResubmitted
    case Other
}

extension CEFNavigationType {
    static func fromCEF(value: cef_navigation_type_t) -> CEFNavigationType {
        return CEFNavigationType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_navigation_type_t {
        return cef_navigation_type_t(rawValue: UInt32(rawValue))
    }
}

