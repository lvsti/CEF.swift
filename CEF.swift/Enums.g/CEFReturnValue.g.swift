//
//  CEFReturnValue.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Return value types.
///
public enum CEFReturnValue: Int32 {

    ///
    // Cancel immediately.
    ///
    case Cancel = 0

    ///
    // Continue immediately.
    ///
    case Continue

    ///
    // Continue asynchronously (usually via a callback).
    ///
    case ContinueAsync
}

extension CEFReturnValue {
    static func fromCEF(value: cef_return_value_t) -> CEFReturnValue {
        return CEFReturnValue(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_return_value_t {
        return cef_return_value_t(rawValue: UInt32(rawValue))
    }
}

