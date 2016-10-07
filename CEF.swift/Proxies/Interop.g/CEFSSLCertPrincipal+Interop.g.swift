//
//  CEFSSLCertPrincipal+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_ssl_info.h.
//

import Foundation

extension cef_sslcert_principal_t: CEFObject {}

/// Class representing the issuer or subject field of an X.509 certificate.
/// CEF name: `CefSSLCertPrincipal`
public class CEFSSLCertPrincipal: CEFProxy<cef_sslcert_principal_t> {
    override init?(ptr: UnsafeMutablePointer<cef_sslcert_principal_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_sslcert_principal_t>?) -> CEFSSLCertPrincipal? {
        return CEFSSLCertPrincipal(ptr: ptr)
    }
}

