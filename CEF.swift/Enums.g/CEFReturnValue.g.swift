//
//  CEFReturnValue.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Return value types.
/// CEF name: `cef_return_value_t`.
public enum CEFReturnValue: Int32 {

    /// Cancel immediately.
    /// CEF name: `RV_CANCEL`.
    case cancel = 0

    /// Continue immediately.
    /// CEF name: `RV_CONTINUE`.
    case continueNow

    /// Continue asynchronously (usually via a callback).
    /// CEF name: `RV_CONTINUE_ASYNC`.
    case continueAsync
}

extension CEFReturnValue {
    static func fromCEF(_ value: cef_return_value_t) -> CEFReturnValue {
        return CEFReturnValue(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_return_value_t {
        return cef_return_value_t(rawValue: UInt32(rawValue))
    }
}

