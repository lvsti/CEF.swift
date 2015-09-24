//
//  DOMVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dom.h.
//

import Foundation

extension cef_domvisitor_t: CEFObject {}

typealias DOMVisitorMarshaller = Marshaller<DOMVisitor, cef_domvisitor_t>

extension DOMVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_domvisitor_t> {
        return DOMVisitorMarshaller.pass(self)
    }
}

extension cef_domvisitor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = DOMVisitor_visit
    }
}
