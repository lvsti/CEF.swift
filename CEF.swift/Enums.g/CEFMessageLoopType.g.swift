//
//  CEFMessageLoopType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Message loop types. Indicates the set of asynchronous events that a message
/// loop can process.
/// CEF name: `cef_message_loop_type_t`.
public enum CEFMessageLoopType: Int32 {

    /// Supports tasks and timers.
    /// CEF name: `ML_TYPE_DEFAULT`.
    case `default`

    /// Supports tasks, timers and native UI events (e.g. Windows messages).
    /// CEF name: `ML_TYPE_UI`.
    case ui

    /// Supports tasks, timers and asynchronous IO events.
    /// CEF name: `ML_TYPE_IO`.
    case io
}

extension CEFMessageLoopType {
    static func fromCEF(_ value: cef_message_loop_type_t) -> CEFMessageLoopType {
        return CEFMessageLoopType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_message_loop_type_t {
        return cef_message_loop_type_t(rawValue: UInt32(rawValue))
    }
}

