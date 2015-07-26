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

public struct CEFPoint {
    public var x:Int = 0
    public var y:Int = 0
    
    public var isEmpty: Bool { get { return x <= 0 && y <= 0 } }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public mutating func set(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func toCEF() -> cef_point_t {
        return cef_point_t(x: Int32(x), y: Int32(y))
    }
}

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

public struct CEFKeyEvent {
    public var type: CEFKeyEventType = .RawKeyDown
    public var modifiers: CEFEventFlags = CEFEventFlags.None
    public var windowsKeyCode: Int = 0
    public var nativeKeyCode: Int = 0
    public var isSystemKey: Bool = false
    public var character: UnicodeScalar = UnicodeScalar(0)
    public var unmodifiedCharacter: UnicodeScalar = UnicodeScalar(0)
    public var focusOnEditableField: Bool = false
    
    func toCEF() -> cef_key_event_t {
        var cefStruct = cef_key_event_t()
        
        cefStruct.type = type.toCEF()
        cefStruct.modifiers = modifiers.toCEF().rawValue
        cefStruct.windows_key_code = Int32(windowsKeyCode)
        cefStruct.native_key_code = Int32(nativeKeyCode)
        cefStruct.is_system_key = isSystemKey ? 1 : 0
        cefStruct.character = UInt16(character.value)
        cefStruct.unmodified_character = UInt16(unmodifiedCharacter.value)
        cefStruct.focus_on_editable_field = focusOnEditableField ? 1 : 0
        
        return cefStruct
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

public struct CEFMouseEvent {
    public var x: Int = 0
    public var y: Int = 0
    public var modifiers: CEFEventFlags = CEFEventFlags.None
    
    func toCEF() -> cef_mouse_event_t {
        var cefStruct = cef_mouse_event_t()
        cefStruct.x = Int32(x)
        cefStruct.y = Int32(y)
        cefStruct.modifiers = modifiers.toCEF().rawValue
        return cefStruct
    }
}

public struct CEFWindowInfo {
    public var windowName: String = ""
    public var x: Int = 0
    public var y: Int = 0
    public var width: Int = 0
    public var height: Int = 0
    public var isHidden: Bool = false
    public var parentView: CEFWindowHandle? = nil
    public var windowlessRenderingEnabled: Bool = false
    public var transparentPaintingEnabled: Bool = false
    public var view: CEFWindowHandle? = nil
    
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefString: &cefStruct.window_name)
        cefStruct.x = Int32(x)
        cefStruct.y = Int32(y)
        cefStruct.width = Int32(width)
        cefStruct.height = Int32(height)
        cefStruct.hidden = isHidden ? 1 : 0
        
        if let parentView = parentView {
            cefStruct.parent_view = UnsafeMutablePointer<Void>(Unmanaged<NSView>.passUnretained(parentView).toOpaque())
        } else {
            cefStruct.parent_view = nil
        }
        
        cefStruct.windowless_rendering_enabled = windowlessRenderingEnabled ? 1 : 0
        cefStruct.transparent_painting_enabled = transparentPaintingEnabled ? 1 : 0
        
        if let view = view {
            cefStruct.view = UnsafeMutablePointer<Void>(Unmanaged<NSView>.passUnretained(view).toOpaque())
        } else {
            cefStruct.view = nil
        }
        
        return cefStruct
    }
}

extension cef_window_info_t {
    mutating func clear() {
        cef_string_utf16_clear(&window_name)
    }
}
