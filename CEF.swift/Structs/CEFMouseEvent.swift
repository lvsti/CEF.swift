//
//  CEFMouseEvent.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

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
