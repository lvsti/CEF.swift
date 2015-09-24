//
//  CookieVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_cookie_visitor_t: CEFObject {}

typealias CookieVisitorMarshaller = Marshaller<CookieVisitor, cef_cookie_visitor_t>

extension CookieVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_cookie_visitor_t> {
        return CookieVisitorMarshaller.pass(self)
    }
}

extension cef_cookie_visitor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CookieVisitor_visit
    }
}
