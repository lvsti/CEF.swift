//
//  CEFV8AccessControl.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// V8 access control values.
/// CEF name: `cef_v8_accesscontrol_t`.
public struct CEFV8AccessControl: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `V8_ACCESS_CONTROL_DEFAULT`.
    public static let defaultAccess = CEFV8AccessControl(rawValue: 0)
    /// CEF name: `V8_ACCESS_CONTROL_ALL_CAN_READ`.
    public static let allCanRead = CEFV8AccessControl(rawValue: 1)
    /// CEF name: `V8_ACCESS_CONTROL_ALL_CAN_WRITE`.
    public static let allCanWrite = CEFV8AccessControl(rawValue: 1 << 1)
    /// CEF name: `V8_ACCESS_CONTROL_PROHIBITS_OVERWRITING`.
    public static let prohibitsOverwriting = CEFV8AccessControl(rawValue: 1 << 2)
}

extension CEFV8AccessControl {
    static func fromCEF(_ value: cef_v8_accesscontrol_t) -> CEFV8AccessControl {
        return CEFV8AccessControl(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_v8_accesscontrol_t {
        return cef_v8_accesscontrol_t(rawValue: UInt32(rawValue))
    }
}

