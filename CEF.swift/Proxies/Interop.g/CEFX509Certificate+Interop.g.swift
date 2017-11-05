//
//  CEFX509Certificate+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_x509_certificate.h.
//

import Foundation

extension cef_x509certificate_t: CEFObject {}

/// Class representing a X.509 certificate.
/// CEF name: `CefX509Certificate`
public final class CEFX509Certificate: CEFProxy<cef_x509certificate_t> {
    override init?(ptr: UnsafeMutablePointer<cef_x509certificate_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_x509certificate_t>?) -> CEFX509Certificate? {
        return CEFX509Certificate(ptr: ptr)
    }
}

