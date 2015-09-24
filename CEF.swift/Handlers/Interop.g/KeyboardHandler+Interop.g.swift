//
//  KeyboardHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_keyboard_handler.h.
//

import Foundation

extension cef_keyboard_handler_t: CEFObject {}

typealias KeyboardHandlerMarshaller = Marshaller<KeyboardHandler, cef_keyboard_handler_t>

extension KeyboardHandler {
    func toCEF() -> UnsafeMutablePointer<cef_keyboard_handler_t> {
        return KeyboardHandlerMarshaller.pass(self)
    }
}

extension cef_keyboard_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_pre_key_event = KeyboardHandler_on_pre_key_event
        on_key_event = KeyboardHandler_on_key_event
    }
}
