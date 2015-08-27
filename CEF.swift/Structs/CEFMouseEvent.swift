//
//  CEFMouseEvent.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Structure representing mouse event information.
///
public struct CEFMouseEvent {
    ///
    // X coordinate relative to the left side of the view.
    ///
    public var x: Int32 = 0

    ///
    // Y coordinate relative to the top side of the view.
    ///
    public var y: Int32 = 0
    
    ///
    // Bit flags describing any pressed modifier keys. See
    // cef_event_flags_t for values.
    ///
    public var modifiers: CEFEventFlags = .None
}

extension CEFMouseEvent {
    func toCEF() -> cef_mouse_event_t {
        var cefStruct = cef_mouse_event_t()
        cefStruct.x = x
        cefStruct.y = y
        cefStruct.modifiers = modifiers.toCEF().rawValue
        return cefStruct
    }
}
