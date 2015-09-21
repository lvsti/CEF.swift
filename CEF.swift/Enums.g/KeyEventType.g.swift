//
//  KeyEventType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Key event types.
public enum KeyEventType: Int32 {

    /// Notification that a key transitioned from "up" to "down".
    case RawKeyDown = 0

    /// Notification that a key was pressed. This does not necessarily correspond
    /// to a character depending on the key and language. Use KEYEVENT_CHAR for
    /// character input.
    case KeyDown

    /// Notification that a key was released.
    case KeyUp

    /// Notification that a character was typed. Use this for text input. Key
    /// down events may generate 0, 1, or more than one character event depending
    /// on the key, locale, and operating system.
    case Char
}

extension KeyEventType {
    static func fromCEF(value: cef_key_event_type_t) -> KeyEventType {
        return KeyEventType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_key_event_type_t {
        return cef_key_event_type_t(rawValue: UInt32(rawValue))
    }
}

