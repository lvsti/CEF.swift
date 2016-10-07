//
//  CEFBrowserHost+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_browser_host_t: CEFObject {}

/// Class used to represent the browser process aspects of a browser window. The
/// methods of this class can only be called in the browser process. They may be
/// called on any thread in that process unless otherwise indicated in the
/// comments.
/// CEF name: `CefBrowserHost`
public class CEFBrowserHost: CEFProxy<cef_browser_host_t> {
    override init?(ptr: UnsafeMutablePointer<cef_browser_host_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_browser_host_t>?) -> CEFBrowserHost? {
        return CEFBrowserHost(ptr: ptr)
    }
}

