//
//  CEFScreenInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Screen information used when window rendering is disabled. This structure is
/// passed as a parameter to CefRenderHandler::GetScreenInfo and should be filled
/// in by the client.
public struct CEFScreenInfo {
    /// Device scale factor. Specifies the ratio between physical and logical
    /// pixels.
    public var scaleFactor: Double
    
    /// The screen depth in bits per pixel.
    public var depth: Int
    
    /// The bits per color component. This assumes that the colors are balanced
    /// equally.
    public var depthPerComponent: Int
    
    /// This can be true for black and white printers.
    public var isMonochrome: Bool
    
    /// This is set from the rcMonitor member of MONITORINFOEX, to whit:
    /// "A RECT structure that specifies the display monitor rectangle,
    /// expressed in virtual-screen coordinates. Note that if the monitor
    /// is not the primary display monitor, some of the rectangle's
    /// coordinates may be negative values."
    /// The |rect| and |available_rect| properties are used to determine the
    /// available surface for rendering popup views.
    public var rect: NSRect
    
    /// This is set from the rcWork member of MONITORINFOEX, to whit:
    /// "A RECT structure that specifies the work area rectangle of the
    /// display monitor that can be used by applications, expressed in
    /// virtual-screen coordinates. Windows uses this rectangle to
    /// maximize an application on the monitor. The rest of the area in
    /// rcMonitor contains system windows such as the task bar and side
    /// bars. Note that if the monitor is not the primary display monitor,
    /// some of the rectangle's coordinates may be negative values".
    /// The |rect| and |available_rect| properties are used to determine the
    /// available surface for rendering popup views.
    public var availableRect: NSRect

}

extension CEFScreenInfo {
    func toCEF() -> cef_screen_info_t {
        return cef_screen_info_t(device_scale_factor: Float(scaleFactor),
                                 depth: Int32(depth),
                                 depth_per_component: Int32(depthPerComponent),
                                 is_monochrome: isMonochrome ? 1 : 0,
                                 rect: rect.toCEF(),
                                 available_rect: availableRect.toCEF())
    }
    
    static func fromCEF(_ value: cef_screen_info_t) -> CEFScreenInfo {
        return CEFScreenInfo(scaleFactor: Double(value.device_scale_factor),
                             depth: Int(value.depth),
                             depthPerComponent: Int(value.depth_per_component),
                             isMonochrome: value.is_monochrome != 0,
                             rect: NSRect.fromCEF(value.rect),
                             availableRect: NSRect.fromCEF(value.available_rect))
    }
}


