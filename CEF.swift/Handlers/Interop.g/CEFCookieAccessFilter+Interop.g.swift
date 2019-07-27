//
//  CEFCookieAccessFilter+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_request_handler.h.
//

import Foundation

extension cef_cookie_access_filter_t: CEFObject {}

typealias CEFCookieAccessFilterMarshaller = CEFMarshaller<CEFCookieAccessFilter, cef_cookie_access_filter_t>

extension CEFCookieAccessFilter {
    func toCEF() -> UnsafeMutablePointer<cef_cookie_access_filter_t> {
        return CEFCookieAccessFilterMarshaller.pass(self)
    }
}

extension cef_cookie_access_filter_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        can_send_cookie = CEFCookieAccessFilter_can_send_cookie
        can_save_cookie = CEFCookieAccessFilter_can_save_cookie
    }
}
