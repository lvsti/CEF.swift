//
//  CEFSelectClientCertificateCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_handler.h.
//

import Foundation

extension cef_select_client_certificate_callback_t: CEFObject {}

/// Callback interface used to select a client certificate for authentication.
/// CEF name: `CefSelectClientCertificateCallback`
public final class CEFSelectClientCertificateCallback: CEFProxy<cef_select_client_certificate_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_select_client_certificate_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_select_client_certificate_callback_t>?) -> CEFSelectClientCertificateCallback? {
        return CEFSelectClientCertificateCallback(ptr: ptr)
    }
}

