//
//  CEFX509CertPrincipal+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_x509_certificate.h.
//

import Foundation

extension cef_x509cert_principal_t: CEFObject {}

/// Class representing the issuer or subject field of an X.509 certificate.
/// CEF name: `CefX509CertPrincipal`
public class CEFX509CertPrincipal: CEFProxy<cef_x509cert_principal_t> {
    override init?(ptr: UnsafeMutablePointer<cef_x509cert_principal_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_x509cert_principal_t>?) -> CEFX509CertPrincipal? {
        return CEFX509CertPrincipal(ptr: ptr)
    }
}

