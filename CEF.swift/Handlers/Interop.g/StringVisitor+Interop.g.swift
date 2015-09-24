//
//  StringVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_string_visitor.h.
//

import Foundation

extension cef_string_visitor_t: CEFObject {}

typealias StringVisitorMarshaller = Marshaller<StringVisitor, cef_string_visitor_t>

extension StringVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_string_visitor_t> {
        return StringVisitorMarshaller.pass(self)
    }
}

extension cef_string_visitor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = StringVisitor_visit
    }
}
