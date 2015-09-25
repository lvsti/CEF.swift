//
//  CEFSSLInfo+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_ssl_info.h.
//

import Foundation

extension cef_sslinfo_t: CEFObject {}

/// Class representing SSL information.
public class CEFSSLInfo: CEFProxy<cef_sslinfo_t> {
    override init?(ptr: UnsafeMutablePointer<cef_sslinfo_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_sslinfo_t>) -> CEFSSLInfo? {
        return CEFSSLInfo(ptr: ptr)
    }
}

