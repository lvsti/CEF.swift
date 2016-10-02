//
//  CEFV8PropertyAttribute.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// V8 property attribute values.
public struct CEFV8PropertyAttribute: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Writeable, Enumerable,
    /// Configurable
    public static let none = CEFV8PropertyAttribute(rawValue: 0)

    /// Not writeable
    public static let readOnly = CEFV8PropertyAttribute(rawValue: 1 << 0)

    /// Not enumerable
    public static let dontEnumerate = CEFV8PropertyAttribute(rawValue: 1 << 1)

    /// Not configurable
    public static let dontDelete = CEFV8PropertyAttribute(rawValue: 1 << 2)
}

extension CEFV8PropertyAttribute {
    static func fromCEF(value: cef_v8_propertyattribute_t) -> CEFV8PropertyAttribute {
        return CEFV8PropertyAttribute(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_v8_propertyattribute_t {
        return cef_v8_propertyattribute_t(rawValue: UInt32(rawValue))
    }
}

