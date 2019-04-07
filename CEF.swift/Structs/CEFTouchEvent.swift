//
//  CEFTouchEvent.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 04. 07..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing touch event information.
/// CEF name: `cef_touch_event_t`
public struct CEFTouchEvent {
    /// Id of a touch point. Must be unique per touch, can be any number except -1.
    /// Note that a maximum of 16 concurrent touches will be tracked; touches
    /// beyond that will be ignored.
    /// CEF name: `id`
    public var id: Int
    
    /// X coordinate relative to the left side of the view.
    /// CEF name: `x`
    public var x: Float
    
    /// Y coordinate relative to the top side of the view.
    /// CEF name: `y`
    public var y: Float
    
    /// X radius in pixels. Set to 0 if not applicable.
    /// CEF name: `radius_x`
    public var xRadius: Float
    
    /// Y radius in pixels. Set to 0 if not applicable.
    /// CEF name: `radius_y`
    public var yRadius: Float

    /// Rotation angle in radians. Set to 0 if not applicable.
    /// CEF name: `radius_x`
    public var rotationAngle: Float
    
    /// The normalized pressure of the pointer input in the range of [0,1].
    /// Set to 0 if not applicable.
    /// CEF name: `pressure`
    public var pressure: Float

    /// The state of the touch point. Touches begin with one CEF_TET_PRESSED event
    /// followed by zero or more CEF_TET_MOVED events and finally one
    /// CEF_TET_RELEASED or CEF_TET_CANCELLED event. Events not respecting this
    /// order will be ignored.
    /// CEF name: `type`
    public var type: CEFTouchEventType
    
    /// Bit flags describing any pressed modifier keys. See
    /// cef_event_flags_t for values.
    /// CEF name: `modifiers`
    public var modifiers: CEFEventFlags
    
    /// The device type that caused the event.
    /// CEF name: `pointer_type`
    public var pointerType: CEFPointerType
}

extension CEFTouchEvent {
    func toCEF() -> cef_touch_event_t {
        var cefStruct = cef_touch_event_t()
        cefStruct.id = Int32(id)
        cefStruct.x = x
        cefStruct.y = y
        cefStruct.radius_x = xRadius
        cefStruct.radius_y = yRadius
        cefStruct.rotation_angle = rotationAngle
        cefStruct.pressure = pressure
        cefStruct.type = type.toCEF()
        cefStruct.modifiers = modifiers.toCEF().rawValue
        cefStruct.pointer_type = pointerType.toCEF()
        return cefStruct
    }
}
