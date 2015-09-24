//
//  SetCookieCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_set_cookie_callback_t: CEFObject {}

typealias SetCookieCallbackMarshaller = Marshaller<SetCookieCallback, cef_set_cookie_callback_t>

extension SetCookieCallback {
    func toCEF() -> UnsafeMutablePointer<cef_set_cookie_callback_t> {
        return SetCookieCallbackMarshaller.pass(self)
    }
}

extension cef_set_cookie_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = SetCookieCallback_on_complete
    }
}
