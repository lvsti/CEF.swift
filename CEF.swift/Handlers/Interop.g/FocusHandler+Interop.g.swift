//
//  FocusHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_focus_handler.h.
//

import Foundation

extension cef_focus_handler_t: CEFObject {}

typealias FocusHandlerMarshaller = Marshaller<FocusHandler, cef_focus_handler_t>

extension FocusHandler {
    func toCEF() -> UnsafeMutablePointer<cef_focus_handler_t> {
        return FocusHandlerMarshaller.pass(self)
    }
}

extension cef_focus_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_take_focus = FocusHandler_on_take_focus
        on_set_focus = FocusHandler_on_set_focus
        on_got_focus = FocusHandler_on_got_focus
    }
}
