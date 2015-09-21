//
//  V8PropertyAttribute.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// V8 property attribute values.
public struct V8PropertyAttribute: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Writeable, Enumerable,
    /// Configurable
    public static let None = V8PropertyAttribute(rawValue: 0)

    /// Not writeable
    public static let ReadOnly = V8PropertyAttribute(rawValue: 1 << 0)

    /// Not enumerable
    public static let DontEnumerate = V8PropertyAttribute(rawValue: 1 << 1)

    /// Not configurable
    public static let DontDelete = V8PropertyAttribute(rawValue: 1 << 2)
}

extension V8PropertyAttribute {
    static func fromCEF(value: cef_v8_propertyattribute_t) -> V8PropertyAttribute {
        return V8PropertyAttribute(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_v8_propertyattribute_t {
        return cef_v8_propertyattribute_t(rawValue: UInt32(rawValue))
    }
}

