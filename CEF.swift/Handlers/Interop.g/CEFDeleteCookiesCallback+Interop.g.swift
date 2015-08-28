//
//  CEFDeleteCookiesCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_delete_cookies_callback_t: CEFObject {}

typealias CEFDeleteCookiesCallbackMarshaller = CEFMarshaller<CEFDeleteCookiesCallback, cef_delete_cookies_callback_t>

extension CEFDeleteCookiesCallback {
    func toCEF() -> UnsafeMutablePointer<cef_delete_cookies_callback_t> {
        return CEFDeleteCookiesCallbackMarshaller.pass(self)
    }
}

extension cef_delete_cookies_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CEFDeleteCookiesCallback_on_complete
    }
}
