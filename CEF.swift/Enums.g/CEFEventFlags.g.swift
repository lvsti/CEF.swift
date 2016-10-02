//
//  CEFEventFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported event bit flags.
public struct CEFEventFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = CEFEventFlags(rawValue: 0)
    public static let capsLockOn = CEFEventFlags(rawValue: 1 << 0)
    public static let shiftDown = CEFEventFlags(rawValue: 1 << 1)
    public static let controlDown = CEFEventFlags(rawValue: 1 << 2)
    public static let altDown = CEFEventFlags(rawValue: 1 << 3)
    public static let leftMouseButton = CEFEventFlags(rawValue: 1 << 4)
    public static let middleMouseButton = CEFEventFlags(rawValue: 1 << 5)

    /// Mac OS-X command key.
    public static let rightMouseButton = CEFEventFlags(rawValue: 1 << 6)
    public static let commandDown = CEFEventFlags(rawValue: 1 << 7)
    public static let numLockOn = CEFEventFlags(rawValue: 1 << 8)
    public static let isKeyPad = CEFEventFlags(rawValue: 1 << 9)
    public static let isLeft = CEFEventFlags(rawValue: 1 << 10)
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

