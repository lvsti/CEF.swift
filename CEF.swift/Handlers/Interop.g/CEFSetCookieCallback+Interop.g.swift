//
//  CEFSetCookieCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_set_cookie_callback_t: CEFObject {}

typealias CEFSetCookieCallbackMarshaller = CEFMarshaller<CEFSetCookieCallback, cef_set_cookie_callback_t>

extension cef_set_cookie_callback_t {
    func toCEF() -> UnsafeMutablePointer<cef_set_cookie_callback_t> {
        return CEFSetCookieCallbackMarshaller.pass(self)
    }
}

extension cef_set_cookie_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CEFSetCookieCallback_on_complete
    }
}
