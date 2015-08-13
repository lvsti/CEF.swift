//
//  CEFKeyEvent.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFKeyEvent {
    public var type: CEFKeyEventType = .RawKeyDown
    public var modifiers: CEFEventFlags = .None
    public var windowsKeyCode: Int32 = 0
    public var nativeKeyCode: Int32 = 0
    public var isSystemKey: Bool = false
    public var character: UInt16 = 0
    public var unmodifiedCharacter: UInt16 = 0
    public var focusOnEditableField: Bool = false
}

extension CEFKeyEvent {
    func toCEF() -> cef_key_event_t {
        var cefStruct = cef_key_event_t()
        
        cefStruct.type = type.toCEF()
        cefStruct.modifiers = modifiers.toCEF().rawValue
        cefStruct.windows_key_code = windowsKeyCode
        cefStruct.native_key_code = nativeKeyCode
        cefStruct.is_system_key = isSystemKey ? 1 : 0
        cefStruct.character = character
        cefStruct.unmodified_character = unmodifiedCharacter
        cefStruct.focus_on_editable_field = focusOnEditableField ? 1 : 0
        
        return cefStruct
    }
    
    static func fromCEF(value: cef_key_event_t) -> CEFKeyEvent {
        return CEFKeyEvent(type: CEFKeyEventType.fromCEF(value.type),
                           modifiers: CEFEventFlags.fromCEF(cef_event_flags_t(rawValue: value.modifiers)),
                           windowsKeyCode: value.windows_key_code,
                           nativeKeyCode: value.native_key_code,
                           isSystemKey: value.is_system_key != 0,
                           character: value.character,
                           unmodifiedCharacter: value.unmodified_character,
                           focusOnEditableField: value.focus_on_editable_field != 0)
    }
}
