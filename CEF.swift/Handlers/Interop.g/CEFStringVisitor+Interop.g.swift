//
//  CEFStringVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_string_visitor.h.
//

import Foundation

extension cef_string_visitor_t: CEFObject {}

typealias CEFStringVisitorMarshaller = CEFMarshaller<CEFStringVisitor, cef_string_visitor_t>

extension cef_string_visitor_t {
    func toCEF() -> UnsafeMutablePointer<cef_string_visitor_t> {
        return CEFStringVisitorMarshaller.pass(self)
    }
}

extension cef_string_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFStringVisitor_visit
    }
}
