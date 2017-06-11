//
//  CEFAccessibilityHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_accessibility_handler.h.
//

import Foundation

extension cef_accessibility_handler_t: CEFObject {}

typealias CEFAccessibilityHandlerMarshaller = CEFMarshaller<CEFAccessibilityHandler, cef_accessibility_handler_t>

extension CEFAccessibilityHandler {
    func toCEF() -> UnsafeMutablePointer<cef_accessibility_handler_t> {
        return CEFAccessibilityHandlerMarshaller.pass(self)
    }
}

extension cef_accessibility_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_accessibility_tree_change = CEFAccessibilityHandler_on_accessibility_tree_change
        on_accessibility_location_change = CEFAccessibilityHandler_on_accessibility_location_change
    }
}
