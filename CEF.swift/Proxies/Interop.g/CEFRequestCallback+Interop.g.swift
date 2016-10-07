//
//  CEFRequestCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_handler.h.
//

import Foundation

extension cef_request_callback_t: CEFObject {}

/// Callback interface used for asynchronous continuation of url requests.
/// CEF name: `CefRequestCallback`
public class CEFRequestCallback: CEFProxy<cef_request_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_request_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_request_callback_t>?) -> CEFRequestCallback? {
        return CEFRequestCallback(ptr: ptr)
    }
}

