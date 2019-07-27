//
//  CEFResourceReadCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_handler.h.
//

import Foundation

extension cef_resource_read_callback_t: CEFObject {}

/// Callback for asynchronous continuation of CefResourceHandler::Read().
/// CEF name: `CefResourceReadCallback`
public final class CEFResourceReadCallback: CEFProxy<cef_resource_read_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_resource_read_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_resource_read_callback_t>?) -> CEFResourceReadCallback? {
        return CEFResourceReadCallback(ptr: ptr)
    }
}

