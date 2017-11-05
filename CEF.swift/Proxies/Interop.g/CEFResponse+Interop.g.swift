//
//  CEFResponse+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_response.h.
//

import Foundation

extension cef_response_t: CEFObject {}

/// Class used to represent a web response. The methods of this class may be
/// called on any thread.
/// CEF name: `CefResponse`
public final class CEFResponse: CEFProxy<cef_response_t> {
    override init?(ptr: UnsafeMutablePointer<cef_response_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_response_t>?) -> CEFResponse? {
        return CEFResponse(ptr: ptr)
    }
}

