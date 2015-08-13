//
//  CEFWindowInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


public struct CEFWindowInfo {
    public var windowName: String = ""
    public var rect: NSRect = NSRect.zeroRect
    public var isHidden: Bool = false
    public var parentView: CEFWindowHandle? = nil
    public var windowlessRenderingEnabled: Bool = false
    public var transparentPaintingEnabled: Bool = false
    public var view: CEFWindowHandle? = nil
    
    public init() {
    }
}

extension CEFWindowInfo {
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefString: &cefStruct.window_name)
        cefStruct.x = Int32(rect.origin.x)
        cefStruct.y = Int32(rect.origin.y)
        cefStruct.width = Int32(rect.size.width)
        cefStruct.height = Int32(rect.size.height)
        cefStruct.hidden = isHidden ? 1 : 0
        
        if let parentView = parentView {
            cefStruct.parent_view = UnsafeMutablePointer<Void>(Unmanaged<CEFWindowHandle>.passUnretained(parentView).toOpaque())
        } else {
            cefStruct.parent_view = nil
        }
        
        cefStruct.windowless_rendering_enabled = windowlessRenderingEnabled ? 1 : 0
        cefStruct.transparent_painting_enabled = transparentPaintingEnabled ? 1 : 0
        
        if let view = view {
            cefStruct.view = UnsafeMutablePointer<Void>(Unmanaged<CEFWindowHandle>.passUnretained(view).toOpaque())
        } else {
            cefStruct.view = nil
        }
        
        return cefStruct
    }
    
    static func fromCEF(value: cef_window_info_t) -> CEFWindowInfo {
        var winInfo = CEFWindowInfo()
        winInfo.windowName = CEFStringToSwiftString(value.window_name)
        winInfo.rect = NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height))
        winInfo.isHidden = value.hidden != 0
        winInfo.parentView = Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(value.parent_view)).takeUnretainedValue()
        winInfo.windowlessRenderingEnabled = value.windowless_rendering_enabled != 0
        winInfo.transparentPaintingEnabled = value.transparent_painting_enabled != 0
        winInfo.view = Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(value.view)).takeUnretainedValue()
        
        return winInfo
    }
}

extension cef_window_info_t {
    mutating func clear() {
        cef_string_utf16_clear(&window_name)
    }
}
