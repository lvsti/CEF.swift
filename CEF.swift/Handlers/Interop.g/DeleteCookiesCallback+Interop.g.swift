//
//  DeleteCookiesCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_delete_cookies_callback_t: CEFObject {}

typealias DeleteCookiesCallbackMarshaller = Marshaller<DeleteCookiesCallback, cef_delete_cookies_callback_t>

extension DeleteCookiesCallback {
    func toCEF() -> UnsafeMutablePointer<cef_delete_cookies_callback_t> {
        return DeleteCookiesCallbackMarshaller.pass(self)
    }
}

extension cef_delete_cookies_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = DeleteCookiesCallback_on_complete
    }
}
