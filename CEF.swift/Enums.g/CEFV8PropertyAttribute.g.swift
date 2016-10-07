//
//  CEFV8PropertyAttribute.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// V8 property attribute values.
/// CEF name: `cef_v8_propertyattribute_t`.
public struct CEFV8PropertyAttribute: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Writeable, Enumerable,
    /// Configurable
    /// CEF name: `V8_PROPERTY_ATTRIBUTE_NONE`.
    public static let none = CEFV8PropertyAttribute(rawValue: 0)

    /// Not writeable
    /// CEF name: `V8_PROPERTY_ATTRIBUTE_READONLY`.
    public static let readOnly = CEFV8PropertyAttribute(rawValue: 1 << 0)

    /// Not enumerable
    /// CEF name: `V8_PROPERTY_ATTRIBUTE_DONTENUM`.
    public static let dontEnumerate = CEFV8PropertyAttribute(rawValue: 1 << 1)

    /// Not configurable
    /// CEF name: `V8_PROPERTY_ATTRIBUTE_DONTDELETE`.
    public static let dontDelete = CEFV8PropertyAttribute(rawValue: 1 << 2)
}

extension CEFV8PropertyAttribute {
    static func fromCEF(_ value: cef_v8_propertyattribute_t) -> CEFV8PropertyAttribute {
        return CEFV8PropertyAttribute(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_v8_propertyattribute_t {
        return cef_v8_propertyattribute_t(rawValue: UInt32(rawValue))
    }
}

