//
//  CEFSSLStatus+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_ssl_status.h.
//

import Foundation

extension cef_sslstatus_t: CEFObject {}

/// Class representing the SSL information for a navigation entry.
/// CEF name: `CefSSLStatus`
public class CEFSSLStatus: CEFProxy<cef_sslstatus_t> {
    override init?(ptr: UnsafeMutablePointer<cef_sslstatus_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_sslstatus_t>?) -> CEFSSLStatus? {
        return CEFSSLStatus(ptr: ptr)
    }
}

