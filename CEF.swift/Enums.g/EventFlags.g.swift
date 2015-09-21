//
//  EventFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported event bit flags.
public struct EventFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = EventFlags(rawValue: 0)
    public static let CapsLockOn = EventFlags(rawValue: 1 << 0)
    public static let ShiftDown = EventFlags(rawValue: 1 << 1)
    public static let ControlDown = EventFlags(rawValue: 1 << 2)
    public static let AltDown = EventFlags(rawValue: 1 << 3)
    public static let LeftMouseButton = EventFlags(rawValue: 1 << 4)
    public static let MiddleMouseButton = EventFlags(rawValue: 1 << 5)

    /// Mac OS-X command key.
    public static let RightMouseButton = EventFlags(rawValue: 1 << 6)
    public static let CommandDown = EventFlags(rawValue: 1 << 7)
    public static let NumLockOn = EventFlags(rawValue: 1 << 8)
    public static let IsKeyPad = EventFlags(rawValue: 1 << 9)
    public static let IsLeft = EventFlags(rawValue: 1 << 10)
    public static let IsRight = EventFlags(rawValue: 1 << 11)
}

extension EventFlags {
    static func fromCEF(value: cef_event_flags_t) -> EventFlags {
        return EventFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_event_flags_t {
        return cef_event_flags_t(rawValue: UInt32(rawValue))
    }
}

