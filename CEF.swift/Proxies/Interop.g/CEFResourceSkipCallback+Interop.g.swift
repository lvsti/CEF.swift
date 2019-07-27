//
//  CEFResourceSkipCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_handler.h.
//

import Foundation

extension cef_resource_skip_callback_t: CEFObject {}

/// Callback for asynchronous continuation of CefResourceHandler::Skip().
/// CEF name: `CefResourceSkipCallback`
public final class CEFResourceSkipCallback: CEFProxy<cef_resource_skip_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_resource_skip_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_resource_skip_callback_t>?) -> CEFResourceSkipCallback? {
        return CEFResourceSkipCallback(ptr: ptr)
    }
}

