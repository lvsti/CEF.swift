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
    public let id: Int
    
    /// X coordinate relative to the left side of the view.
    /// CEF name: `x`
    public let x: Float
    
    /// Y coordinate relative to the top side of the view.
    /// CEF name: `y`
    public let y: Float
    
    /// X radius in pixels. Set to 0 if not applicable.
    /// CEF name: `radius_x`
    public let xRadius: Float
    
    /// Y radius in pixels. Set to 0 if not applicable.
    /// CEF name: `radius_y`
    public let yRadius: Float

    /// Rotation angle in radians. Set to 0 if not applicable.
    /// CEF name: `radius_x`
    public let rotationAngle: Float
    
    /// The normalized pressure of the pointer input in the range of [0,1].
    /// Set to 0 if not applicable.
    /// CEF name: `pressure`
    public let pressure: Float

    /// The state of the touch point. Touches begin with one CEF_TET_PRESSED event
    /// followed by zero or more CEF_TET_MOVED events and finally one
    /// CEF_TET_RELEASED or CEF_TET_CANCELLED event. Events not respecting this
    /// order will be ignored.
    /// CEF name: `type`
    public let type: CEFTouchEventType
    
    /// Bit flags describing any pressed modifier keys. See
    /// cef_event_flags_t for values.
    /// CEF name: `modifiers`
    public let modifiers: CEFEventFlags
    
    /// The device type that caused the event.
    /// CEF name: `pointer_type`
    public let pointerType: CEFPointerType
}

extension CEFTouchEvent {
    static func fromCEF(_ value: cef_touch_event_t) -> CEFTouchEvent {
        return CEFTouchEvent(id: Int(value.id),
                             x: value.x,
                             y: value.y,
                             xRadius: value.radius_x,
                             yRadius: value.radius_y,
                             rotationAngle: value.rotation_angle,
                             pressure: value.pressure,
                             type: CEFTouchEventType.fromCEF(value.type),
                             modifiers: CEFEventFlags(rawValue: value.modifiers),
                             pointerType: CEFPointerType.fromCEF(value.pointer_type))
    }
}
