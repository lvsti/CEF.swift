//
//  CEFCookieVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_cookie_visitor_t: CEFObject {}

typealias CEFCookieVisitorMarshaller = CEFMarshaller<CEFCookieVisitor, cef_cookie_visitor_t>

extension CEFCookieVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_cookie_visitor_t> {
        return CEFCookieVisitorMarshaller.pass(self)
    }
}

extension cef_cookie_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFCookieVisitor_visit
    }
}
