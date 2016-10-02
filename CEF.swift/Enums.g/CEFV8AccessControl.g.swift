//
//  CEFV8AccessControl.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// V8 access control values.
public struct CEFV8AccessControl: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let defaultAccess = CEFV8AccessControl(rawValue: 0)
    public static let allCanRead = CEFV8AccessControl(rawValue: 1)
    public static let allCanWrite = CEFV8AccessControl(rawValue: 1 << 1)
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

