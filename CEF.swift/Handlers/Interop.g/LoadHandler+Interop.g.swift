//
//  LoadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_load_handler.h.
//

import Foundation

extension cef_load_handler_t: CEFObject {}

typealias LoadHandlerMarshaller = Marshaller<LoadHandler, cef_load_handler_t>

extension LoadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_load_handler_t> {
        return LoadHandlerMarshaller.pass(self)
    }
}

extension cef_load_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_loading_state_change = LoadHandler_on_loading_state_change
        on_load_start = LoadHandler_on_load_start
        on_load_end = LoadHandler_on_load_end
        on_load_error = LoadHandler_on_load_error
    }
}
