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
    /// Transparent painting is enabled by default but can be disabled by setting
    /// CefBrowserSettings.background_color to an opaque value.
    /// CEF name: `windowless_rendering_enabled`
    public var useWindowlessRendering: Bool = false
    
    /// Set to true (1) to enable shared textures for windowless rendering. Only
    /// valid if windowless_rendering_enabled above is also set to true. Currently
    /// only supported on Windows (D3D11).
    /// CEF name: `shared_texture_enabled`
    public var useSharedTexture: Bool = false
    
    /// Set to true (1) to enable the ability to issue BeginFrame from the client
    /// application.
    /// CEF name: `external_begin_frame_enabled`
    public var allowExternalBeginFrame: Bool = false
    
    /// NSView pointer for the new browser view. Only used with windowed rendering.
    /// CEF name: `view`
    public var view: CEFWindowHandle? = nil
    
    public init() {
    }
    
    /// Create the browser as a child view.
    /// CEF name: `SetAsChild`
    public mutating func setAsChild(of parentView: CEFWindowHandle, withRect rect: NSRect) {
        self.parentView = parentView
        self.rect = rect
        isHidden = false
    }
    
    /// Create the browser using windowless (off-screen) rendering. No view
    /// will be created for the browser and all rendering will occur via the
    /// CefRenderHandler interface. The |parent| value will be used to identify
    /// monitor info and to act as the parent view for dialogs, context menus,
    /// etc. If |parent| is not provided then the main screen monitor will be used
    /// and some functionality that requires a parent view may not function
    /// correctly. In order to create windowless browsers the
    /// CefSettings.windowless_rendering_enabled value must be set to true.
    /// Transparent painting is enabled by default but can be disabled by setting
    /// CefBrowserSettings.background_color to an opaque value.
    /// CEF name: `SetAsWindowless`
    public mutating func setAsWindowlessChild(of parentView: CEFWindowHandle) {
        self.parentView = parentView
        useWindowlessRendering = true
    }
}

extension CEFWindowInfo {
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefStringPtr: &cefStruct.window_name)
        cefStruct.bounds = rect.toCEF()
        cefStruct.hidden = isHidden ? 1 : 0
        
        if let parentView = parentView {
            cefStruct.parent_view = UnsafeMutableRawPointer(Unmanaged<CEFWindowHandle>.passUnretained(parentView).toOpaque())
        }
        
        cefStruct.windowless_rendering_enabled = useWindowlessRendering ? 1 : 0
        cefStruct.shared_texture_enabled = useSharedTexture ? 1 : 0
        cefStruct.external_begin_frame_enabled = allowExternalBeginFrame ? 1 : 0
        
        if let view = view {
            cefStruct.view = UnsafeMutableRawPointer(Unmanaged<CEFWindowHandle>.passUnretained(view).toOpaque())
        }
        
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_window_info_t) -> CEFWindowInfo {
        var winInfo = CEFWindowInfo()
        winInfo.windowName = CEFStringToSwiftString(value.window_name)
        winInfo.rect = NSRect.fromCEF(value.bounds)
        winInfo.isHidden = value.hidden != 0
        winInfo.parentView = value.parent_view != nil ?
            Unmanaged<CEFWindowHandle>.fromOpaque(value.parent_view).takeUnretainedValue() : nil
        winInfo.useWindowlessRendering = value.windowless_rendering_enabled != 0
        winInfo.useSharedTexture = value.shared_texture_enabled != 0
        winInfo.allowExternalBeginFrame = value.external_begin_frame_enabled != 0
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
