//
//  CEFNavigationEntryVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_navigation_entry_visitor_t: CEFObject {}

typealias CEFNavigationEntryVisitorMarshaller = CEFMarshaller<CEFNavigationEntryVisitor, cef_navigation_entry_visitor_t>

extension cef_navigation_entry_visitor_t {
    func toCEF() -> UnsafeMutablePointer<cef_navigation_entry_visitor_t> {
        return CEFNavigationEntryVisitorMarshaller.pass(self)
    }
}

extension cef_navigation_entry_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFNavigationEntryVisitor_visit
    }
}
