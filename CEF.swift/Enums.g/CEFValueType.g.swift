//
//  CEFValueType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported value types.
/// CEF name: `cef_value_type_t`.
public enum CEFValueType: Int32 {
    /// CEF name: `VTYPE_INVALID`.
    case invalid = 0
    /// CEF name: `VTYPE_NULL`.
    case null
    /// CEF name: `VTYPE_BOOL`.
    case bool
    /// CEF name: `VTYPE_INT`.
    case int
    /// CEF name: `VTYPE_DOUBLE`.
    case double
    /// CEF name: `VTYPE_STRING`.
    case string
    /// CEF name: `VTYPE_BINARY`.
    case binary
    /// CEF name: `VTYPE_DICTIONARY`.
    case dictionary
    /// CEF name: `VTYPE_LIST`.
    case list
}

extension CEFValueType {
    static func fromCEF(_ value: cef_value_type_t) -> CEFValueType {
        return CEFValueType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_value_type_t {
        return cef_value_type_t(rawValue: UInt32(rawValue))
    }
}

