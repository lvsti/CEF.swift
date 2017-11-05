//
//  CEFRequest+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request.h.
//

import Foundation

extension cef_request_t: CEFObject {}

/// Class used to represent a web request. The methods of this class may be
/// called on any thread.
/// CEF name: `CefRequest`
public final class CEFRequest: CEFProxy<cef_request_t> {
    override init?(ptr: UnsafeMutablePointer<cef_request_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_request_t>?) -> CEFRequest? {
        return CEFRequest(ptr: ptr)
    }
}

