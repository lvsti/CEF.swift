//
//  CEFKeyboardHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_keyboard_handler.h.
//

import Foundation

extension cef_keyboard_handler_t: CEFObject {}

typealias CEFKeyboardHandlerMarshaller = CEFMarshaller<CEFKeyboardHandler, cef_keyboard_handler_t>

extension CEFKeyboardHandler {
    func toCEF() -> UnsafeMutablePointer<cef_keyboard_handler_t> {
        return CEFKeyboardHandlerMarshaller.pass(self)
    }
}

extension cef_keyboard_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_pre_key_event = CEFKeyboardHandler_on_pre_key_event
        on_key_event = CEFKeyboardHandler_on_key_event
    }
}
