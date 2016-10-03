//
//  CEFCursorInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing cursor information. |buffer| will be
/// |size.width|*|size.height|*4 bytes in size and represents a BGRA image with
/// an upper-left origin.
public struct CEFCursorInfo {
    public let hotspot: NSPoint
    public let scaleFactor: Double
    public let buffer: UnsafeMutableRawPointer
    public let size: NSSize
}

extension CEFCursorInfo {
    static func fromCEF(_ value: cef_cursor_info_t) -> CEFCursorInfo {
        return CEFCursorInfo(hotspot: NSPoint.fromCEF(value.hotspot),
                             scaleFactor: Double(value.image_scale_factor),
                             buffer: UnsafeMutableRawPointer(value.buffer),
                             size: NSSize.fromCEF(value.size))
    }
}

