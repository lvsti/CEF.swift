//
//  CEFURLRequest+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_urlrequest.h.
//

import Foundation

extension cef_urlrequest_t: CEFObject {}

/// Class used to make a URL request. URL requests are not associated with a
/// browser instance so no CefClient callbacks will be executed. URL requests
/// can be created on any valid CEF thread in either the browser or render
/// process. Once created the methods of the URL request object must be accessed
/// on the same thread that created it.
/// CEF name: `CefURLRequest`
public class CEFURLRequest: CEFProxy<cef_urlrequest_t> {
    override init?(ptr: UnsafeMutablePointer<cef_urlrequest_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_urlrequest_t>?) -> CEFURLRequest? {
        return CEFURLRequest(ptr: ptr)
    }
}

