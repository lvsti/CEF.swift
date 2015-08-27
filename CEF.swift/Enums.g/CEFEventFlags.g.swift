//
//  CEFEventFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported event bit flags.
public struct CEFEventFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = CEFEventFlags(rawValue: 0)
    public static let CapsLockOn = CEFEventFlags(rawValue: 1 << 0)
    public static let ShiftDown = CEFEventFlags(rawValue: 1 << 1)
    public static let ControlDown = CEFEventFlags(rawValue: 1 << 2)
    public static let AltDown = CEFEventFlags(rawValue: 1 << 3)
    public static let LeftMouseButton = CEFEventFlags(rawValue: 1 << 4)
    public static let MiddleMouseButton = CEFEventFlags(rawValue: 1 << 5)

    /// Mac OS-X command key.
    public static let RightMouseButton = CEFEventFlags(rawValue: 1 << 6)
    public static let CommandDown = CEFEventFlags(rawValue: 1 << 7)
    public static let NumLockOn = CEFEventFlags(rawValue: 1 << 8)
    public static let IsKeyPad = CEFEventFlags(rawValue: 1 << 9)
    public static let IsLeft = CEFEventFlags(rawValue: 1 << 10)
    public static let IsRight = CEFEventFlags(rawValue: 1 << 11)
}

extension CEFEventFlags {
    static func fromCEF(value: cef_event_flags_t) -> CEFEventFlags {
        return CEFEventFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_event_flags_t {
        return cef_event_flags_t(rawValue: UInt32(rawValue))
    }
}

