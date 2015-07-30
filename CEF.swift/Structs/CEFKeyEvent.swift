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
