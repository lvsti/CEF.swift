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
    public var x: Int = 0
    public var y: Int = 0
    public var width: Int = 0
    public var height: Int = 0
    public var isHidden: Bool = false
    public var parentView: CEFWindowHandle? = nil
    public var windowlessRenderingEnabled: Bool = false
    public var transparentPaintingEnabled: Bool = false
    public var view: CEFWindowHandle? = nil
    
    public init() {
    }
    
    func toCEF() -> cef_window_info_t {
        var cefStruct = cef_window_info_t()
        
        CEFStringSetFromSwiftString(windowName, cefString: &cefStruct.window_name)
        cefStruct.x = Int32(x)
        cefStruct.y = Int32(y)
        cefStruct.width = Int32(width)
        cefStruct.height = Int32(height)
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
}

extension cef_window_info_t {
    mutating func clear() {
        cef_string_utf16_clear(&window_name)
    }
}
