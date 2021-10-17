//
//  CEFBrowser+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_browser_t: CEFObject {}

/// Class used to represent a browser. When used in the browser process the
/// methods of this class may be called on any thread unless otherwise indicated
/// in the comments. When used in the render process the methods of this class
/// may only be called on the main thread.
/// CEF name: `CefBrowser`
public final class CEFBrowser: CEFProxy<cef_browser_t> {
    override init?(ptr: UnsafeMutablePointer<cef_browser_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_browser_t>?) -> CEFBrowser? {
        return CEFBrowser(ptr: ptr)
    }
}

