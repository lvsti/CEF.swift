//
//  CEFKeyEventType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Key event types.
/// CEF name: `cef_key_event_type_t`.
public enum CEFKeyEventType: Int32 {

    /// Notification that a key transitioned from "up" to "down".
    /// CEF name: `KEYEVENT_RAWKEYDOWN`.
    case rawKeyDown = 0

    /// Notification that a key was pressed. This does not necessarily correspond
    /// to a character depending on the key and language. Use KEYEVENT_CHAR for
    /// character input.
    /// CEF name: `KEYEVENT_KEYDOWN`.
    case keyDown

    /// Notification that a key was released.
    /// CEF name: `KEYEVENT_KEYUP`.
    case keyUp

    /// Notification that a character was typed. Use this for text input. Key
    /// down events may generate 0, 1, or more than one character event depending
    /// on the key, locale, and operating system.
    /// CEF name: `KEYEVENT_CHAR`.
    case char
}

extension CEFKeyEventType {
    static func fromCEF(_ value: cef_key_event_type_t) -> CEFKeyEventType {
        return CEFKeyEventType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_key_event_type_t {
        return cef_key_event_type_t(rawValue: UInt32(rawValue))
    }
}

