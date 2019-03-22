//
//  CEFEventFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported event bit flags.
/// CEF name: `cef_event_flags_t`.
public struct CEFEventFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `EVENTFLAG_NONE`.
    public static let none = CEFEventFlags(rawValue: 0)
    /// CEF name: `EVENTFLAG_CAPS_LOCK_ON`.
    public static let capsLockOn = CEFEventFlags(rawValue: 1 << 0)
    /// CEF name: `EVENTFLAG_SHIFT_DOWN`.
    public static let shiftDown = CEFEventFlags(rawValue: 1 << 1)
    /// CEF name: `EVENTFLAG_CONTROL_DOWN`.
    public static let controlDown = CEFEventFlags(rawValue: 1 << 2)
    /// CEF name: `EVENTFLAG_ALT_DOWN`.
    public static let altDown = CEFEventFlags(rawValue: 1 << 3)
    /// CEF name: `EVENTFLAG_LEFT_MOUSE_BUTTON`.
    public static let leftMouseButton = CEFEventFlags(rawValue: 1 << 4)
    /// CEF name: `EVENTFLAG_MIDDLE_MOUSE_BUTTON`.
    public static let middleMouseButton = CEFEventFlags(rawValue: 1 << 5)
    /// CEF name: `EVENTFLAG_RIGHT_MOUSE_BUTTON`.
    public static let rightMouseButton = CEFEventFlags(rawValue: 1 << 6)

    /// Mac OS-X command key.
    /// CEF name: `EVENTFLAG_COMMAND_DOWN`.
    public static let commandDown = CEFEventFlags(rawValue: 1 << 7)
    /// CEF name: `EVENTFLAG_NUM_LOCK_ON`.
    public static let numLockOn = CEFEventFlags(rawValue: 1 << 8)
    /// CEF name: `EVENTFLAG_IS_KEY_PAD`.
    public static let isKeyPad = CEFEventFlags(rawValue: 1 << 9)
    /// CEF name: `EVENTFLAG_IS_LEFT`.
    public static let isLeft = CEFEventFlags(rawValue: 1 << 10)
    /// CEF name: `EVENTFLAG_IS_RIGHT`.
    public static let isRight = CEFEventFlags(rawValue: 1 << 11)
}

extension CEFEventFlags {
    static func fromCEF(_ value: cef_event_flags_t) -> CEFEventFlags {
        return CEFEventFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_event_flags_t {
        return cef_event_flags_t(rawValue: UInt32(rawValue))
    }
}

