//
//  CEFURLRequestClient+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_urlrequest.h.
//

import Foundation

extension cef_urlrequest_client_t: CEFObject {}

typealias CEFURLRequestClientMarshaller = CEFMarshaller<CEFURLRequestClient, cef_urlrequest_client_t>

extension cef_urlrequest_client_t {
    func toCEF() -> UnsafeMutablePointer<cef_urlrequest_client_t> {
        return CEFURLRequestClientMarshaller.pass(self)
    }
}

extension cef_urlrequest_client_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_complete = CEFURLRequestClient_on_request_complete
        on_upload_progress = CEFURLRequestClient_on_upload_progress
        on_download_progress = CEFURLRequestClient_on_download_progress
        on_download_data = CEFURLRequestClient_on_download_data
        get_auth_credentials = CEFURLRequestClient_get_auth_credentials
    }
}
