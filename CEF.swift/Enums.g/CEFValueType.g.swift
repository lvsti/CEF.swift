//
//  CEFValueType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported value types.
public enum CEFValueType: Int32 {
    case invalid = 0
    case null
    case bool
    case int
    case double
    case string
    case binary
    case dictionary
    case list
}

extension CEFValueType {
    static func fromCEF(value: cef_value_type_t) -> CEFValueType {
        return CEFValueType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_value_type_t {
        return cef_value_type_t(rawValue: UInt32(rawValue))
    }
}

