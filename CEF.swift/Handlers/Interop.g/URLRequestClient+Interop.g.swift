//
//  URLRequestClient+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_urlrequest.h.
//

import Foundation

extension cef_urlrequest_client_t: CEFObject {}

typealias URLRequestClientMarshaller = Marshaller<URLRequestClient, cef_urlrequest_client_t>

extension URLRequestClient {
    func toCEF() -> UnsafeMutablePointer<cef_urlrequest_client_t> {
        return URLRequestClientMarshaller.pass(self)
    }
}

extension cef_urlrequest_client_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_complete = URLRequestClient_on_request_complete
        on_upload_progress = URLRequestClient_on_upload_progress
        on_download_progress = URLRequestClient_on_download_progress
        on_download_data = URLRequestClient_on_download_data
        get_auth_credentials = URLRequestClient_get_auth_credentials
    }
}
