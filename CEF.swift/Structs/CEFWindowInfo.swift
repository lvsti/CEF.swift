//
//  CEFWindowInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


/// Class representing window information.
/// CEF name: `cef_window_info_t`
public struct CEFWindowInfo {
    /// CEF name: `window_name`
    public var windowName: String = ""
    /// CEF name: `x`, `y`, `width`, `height`
    public var rect: NSRect = NSRect.zero

    /// Set to true (1) to create the view initially hidden.
    /// CEF name: `hidden`
    public var isHidden: Bool = false
    
    /// NSView pointer for the parent view.
    /// CEF name: `parent_view`
    public var parentView: CEFWindowHandle? = nil
    
    /// Set to true (1) to create the browser using windowless (off-screen)
    /// rendering. No view will be created for the browser and all rendering will
    /// occur via the CefRenderHandler interface. The |parent_view| value will be
    /// used to identify monitor info and to act as the parent view for dialogs,
    /// context menus, etc. If |parent_view| is not provided then the main screen
    /// monitor will be used and some functionality that requires a parent view
    /// may not function correctly. In order to create windowless browsers the
    /// CefSettings.windowless_rendering_enabled value must be set to true.
    /// CEF name: `windowless_rendering_enabled`
    public var useWindowlessRendering: Bool = false
    
    /// Set to true (1) to enable transparent painting in combination with
    /// windowless rendering. When this value is true a transparent background
    /// color will be used (RGBA=0x00000000). When this value is false the
    /// background will be white and opaque.
    /// CEF name: `transparent_painting_enabled`
    public var useTransparentPainting: Bool = false
    
    /// NSView pointer for the new browser view. Only used with windowed rendering.
    /// CEF name: `view`
    public var view: CEFWindowHandle? = nil
    
    public init() {
    }
}

extension CEFWindowInfo {
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefStringPtr: &cefStruct.window_name)
        cefStruct.x = Int32(rect.origin.x)
        cefStruct.y = Int32(rect.origin.y)
        cefStruct.width = Int32(rect.size.width)
        cefStruct.height = Int32(rect.size.height)
        cefStruct.hidden = isHidden ? 1 : 0
        
        if let parentView = parentView {
            cefStruct.parent_view = UnsafeMutableRawPointer(Unmanaged<CEFWindowHandle>.passUnretained(parentView).toOpaque())
        }
        
        cefStruct.windowless_rendering_enabled = useWindowlessRendering ? 1 : 0
        cefStruct.transparent_painting_enabled = useTransparentPainting ? 1 : 0
        
        if let view = view {
            cefStruct.view = UnsafeMutableRawPointer(Unmanaged<CEFWindowHandle>.passUnretained(view).toOpaque())
        }
        
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_window_info_t) -> CEFWindowInfo {
        var winInfo = CEFWindowInfo()
        winInfo.windowName = CEFStringToSwiftString(value.window_name)
        winInfo.rect = NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height))
        winInfo.isHidden = value.hidden != 0
        winInfo.parentView = value.parent_view != nil ?
            Unmanaged<CEFWindowHandle>.fromOpaque(value.parent_view).takeUnretainedValue() : nil
        winInfo.useWindowlessRendering = value.windowless_rendering_enabled != 0
        winInfo.useTransparentPainting = value.transparent_painting_enabled != 0
        winInfo.view = value.view != nil ?
            Unmanaged<CEFWindowHandle>.fromOpaque(value.view).takeUnretainedValue() : nil
        
        return winInfo
    }
}

extension cef_window_info_t {
    mutating func clear() {
        cef_string_utf16_clear(&window_name)
    }
}
