//
//  WindowInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


/// Class representing window information.
public struct WindowInfo {
    public var windowName: String = ""
    public var rect: NSRect = NSRect.zero

    /// Set to true (1) to create the view initially hidden.
    public var isHidden: Bool = false
    
    /// NSView pointer for the parent view.
    public var parentView: WindowHandle? = nil
    
    /// Set to true (1) to create the browser using windowless (off-screen)
    /// rendering. No view will be created for the browser and all rendering will
    /// occur via the CefRenderHandler interface. The |parent_view| value will be
    /// used to identify monitor info and to act as the parent view for dialogs,
    /// context menus, etc. If |parent_view| is not provided then the main screen
    /// monitor will be used and some functionality that requires a parent view
    /// may not function correctly. In order to create windowless browsers the
    /// CefSettings.windowless_rendering_enabled value must be set to true.
    public var windowlessRenderingEnabled: Bool = false
    
    /// Set to true (1) to enable transparent painting in combination with
    /// windowless rendering. When this value is true a transparent background
    /// color will be used (RGBA=0x00000000). When this value is false the
    /// background will be white and opaque.
    public var transparentPaintingEnabled: Bool = false
    
    /// NSView pointer for the new browser view. Only used with windowed rendering.
    public var view: WindowHandle? = nil
    
    public init() {
    }
}

extension WindowInfo {
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefString: &cefStruct.window_name)
        cefStruct.x = Int32(rect.origin.x)
        cefStruct.y = Int32(rect.origin.y)
        cefStruct.width = Int32(rect.size.width)
        cefStruct.height = Int32(rect.size.height)
        cefStruct.hidden = isHidden ? 1 : 0
        
        if let parentView = parentView {
            cefStruct.parent_view = UnsafeMutablePointer<Void>(Unmanaged<WindowHandle>.passUnretained(parentView).toOpaque())
        } else {
            cefStruct.parent_view = nil
        }
        
        cefStruct.windowless_rendering_enabled = windowlessRenderingEnabled ? 1 : 0
        cefStruct.transparent_painting_enabled = transparentPaintingEnabled ? 1 : 0
        
        if let view = view {
            cefStruct.view = UnsafeMutablePointer<Void>(Unmanaged<WindowHandle>.passUnretained(view).toOpaque())
        } else {
            cefStruct.view = nil
        }
        
        return cefStruct
    }
    
    static func fromCEF(value: cef_window_info_t) -> WindowInfo {
        var winInfo = WindowInfo()
        winInfo.windowName = CEFStringToSwiftString(value.window_name)
        winInfo.rect = NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height))
        winInfo.isHidden = value.hidden != 0
        winInfo.parentView = Unmanaged<WindowHandle>.fromOpaque(COpaquePointer(value.parent_view)).takeUnretainedValue()
        winInfo.windowlessRenderingEnabled = value.windowless_rendering_enabled != 0
        winInfo.transparentPaintingEnabled = value.transparent_painting_enabled != 0
        winInfo.view = Unmanaged<WindowHandle>.fromOpaque(COpaquePointer(value.view)).takeUnretainedValue()
        
        return winInfo
    }
}

extension cef_window_info_t {
    mutating func clear() {
        cef_string_utf16_clear(&window_name)
    }
}
