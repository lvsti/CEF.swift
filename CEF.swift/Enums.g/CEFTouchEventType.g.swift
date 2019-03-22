//
//  CEFTouchEventType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Touch points states types.
/// CEF name: `cef_touch_event_type_t`.
public enum CEFTouchEventType: Int32 {
    /// CEF name: `CEF_TET_RELEASED`.
    case released = 0
    /// CEF name: `CEF_TET_PRESSED`.
    case pressed
    /// CEF name: `CEF_TET_MOVED`.
    case moved
    /// CEF name: `CEF_TET_CANCELLED`.
    case cancelled
}

extension CEFTouchEventType {
    static func fromCEF(_ value: cef_touch_event_type_t) -> CEFTouchEventType {
        return CEFTouchEventType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_touch_event_type_t {
        return cef_touch_event_type_t(rawValue: UInt32(rawValue))
    }
}

