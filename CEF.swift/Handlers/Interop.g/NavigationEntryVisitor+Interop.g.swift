//
//  NavigationEntryVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_navigation_entry_visitor_t: CEFObject {}

typealias NavigationEntryVisitorMarshaller = Marshaller<NavigationEntryVisitor, cef_navigation_entry_visitor_t>

extension NavigationEntryVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_navigation_entry_visitor_t> {
        return NavigationEntryVisitorMarshaller.pass(self)
    }
}

extension cef_navigation_entry_visitor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = NavigationEntryVisitor_visit
    }
}
