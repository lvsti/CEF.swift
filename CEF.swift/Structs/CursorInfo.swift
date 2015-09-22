//
//  CursorInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing cursor information. |buffer| will be
/// |size.width|*|size.height|*4 bytes in size and represents a BGRA image with
/// an upper-left origin.
public struct CursorInfo {
    public let hotspot: NSPoint
    public let scaleFactor: Double
    public let buffer: UnsafeMutablePointer<Void>
    public let size: NSSize
}

extension CursorInfo {
    static func fromCEF(value: cef_cursor_info_t) -> CursorInfo {
        return CursorInfo(hotspot: NSPoint.fromCEF(value.hotspot),
                          scaleFactor: Double(value.image_scale_factor),
                          buffer: UnsafeMutablePointer<Void>(value.buffer),
                          size: NSSize.fromCEF(value.size))
    }
}

