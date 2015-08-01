//
//  CEFEventFlags.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFEventFlags: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let None = CEFEventFlags(rawValue: 0)
    public static let CapsLockOn = CEFEventFlags(rawValue: 1 << 0)
    public static let ShiftDown = CEFEventFlags(rawValue: 1 << 1)
    public static let ControlDown = CEFEventFlags(rawValue: 1 << 2)
    public static let AltDown = CEFEventFlags(rawValue: 1 << 3)
    public static let LeftMouseButton = CEFEventFlags(rawValue: 1 << 4)
    public static let MiddleMouseButton = CEFEventFlags(rawValue: 1 << 5)
    public static let RightMouseButton = CEFEventFlags(rawValue: 1 << 6)
    public static let CommandDown = CEFEventFlags(rawValue: 1 << 7)
    public static let NumLockOn = CEFEventFlags(rawValue: 1 << 8)
    public static let IsKeyPad = CEFEventFlags(rawValue: 1 << 9)
    public static let IsLeft = CEFEventFlags(rawValue: 1 << 10)
    public static let IsRight = CEFEventFlags(rawValue: 1 << 11)
}

extension CEFEventFlags {
    func toCEF() -> cef_event_flags_t {
        return cef_event_flags_t(rawValue: UInt32(rawValue))
    }
}

