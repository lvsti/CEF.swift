//
//  CEFDOMVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dom.h.
//

import Foundation

extension cef_domvisitor_t: CEFObject {}

typealias CEFDOMVisitorMarshaller = CEFMarshaller<CEFDOMVisitor, cef_domvisitor_t>

extension CEFDOMVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_domvisitor_t> {
        return CEFDOMVisitorMarshaller.pass(self)
    }
}

extension cef_domvisitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFDOMVisitor_visit
    }
}
