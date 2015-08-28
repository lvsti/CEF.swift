//
//  CEFFocusHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_focus_handler.h.
//

import Foundation

extension cef_focus_handler_t: CEFObject {}

typealias CEFFocusHandlerMarshaller = CEFMarshaller<CEFFocusHandler, cef_focus_handler_t>

extension cef_focus_handler_t {
    func toCEF() -> UnsafeMutablePointer<cef_focus_handler_t> {
        return CEFFocusHandlerMarshaller.pass(self)
    }
}

extension cef_focus_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_take_focus = CEFFocusHandler_on_take_focus
        on_set_focus = CEFFocusHandler_on_set_focus
        on_got_focus = CEFFocusHandler_on_got_focus
    }
}
