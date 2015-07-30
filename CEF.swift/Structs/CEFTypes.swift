//
//  CEFTypes.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation
import AppKit

public typealias CEFWindowHandle = NSView
public typealias CEFTextInputContext = NSTextInputContext
public typealias CEFEventHandle = NSEvent

public enum CEFPaintElementType: Int {
    case View = 0
    case Popup
    
    func toCEF() -> cef_paint_element_type_t {
        return cef_paint_element_type_t(rawValue: UInt32(rawValue))
    }
}

public enum CEFKeyEventType: Int {
    case RawKeyDown = 0
    case KeyDown
    case KeyUp
    case Char
    
    func toCEF() -> cef_key_event_type_t {
        return cef_key_event_type_t(rawValue: UInt32(rawValue))
    }
}

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
    
    func toCEF() -> cef_event_flags_t {
        return cef_event_flags_t(rawValue: UInt32(rawValue))
    }
}


public enum CEFMouseButtonType: Int {
    case Left = 0
    case Middle
    case Right
    
    func toCEF() -> cef_mouse_button_type_t {
        return cef_mouse_button_type_t(rawValue: UInt32(rawValue))
    }
}


public struct CEFTransitionType: RawRepresentable {
    public let rawValue: UInt
    
    public enum Source: UInt8 {
        case Link = 0
        case Explicit
        case AutoSubframe
        case ManualSubframe
        case FormSubmit
        case Reload
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        public static let Blocked = Flags(rawValue: 0x00800000)
        public static let ForwardBack = Flags(rawValue: 0x01000000)
        public static let ChainStart = Flags(rawValue: 0x10000000)
        public static let ChainEnd = Flags(rawValue: 0x20000000)
        public static let ClientRedirect = Flags(rawValue: 0x40000000)
        public static let ServerRedirect = Flags(rawValue: 0x80000000)
        
        public var isRedirect: Bool { return self.contains(.ClientRedirect) || self.contains(.ServerRedirect) }
    }
    
    public var source: Source { get { return Source(rawValue: UInt8(UInt32(rawValue) & TT_SOURCE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & TT_QUALIFIER_MASK.rawValue)) } }
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    static func fromCEF(value: cef_transition_type_t) -> CEFTransitionType {
        return CEFTransitionType(rawValue: UInt(value.rawValue))
    }
}

