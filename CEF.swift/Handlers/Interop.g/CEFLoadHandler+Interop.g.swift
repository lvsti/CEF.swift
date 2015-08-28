//
//  CEFLoadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_load_handler.h.
//

import Foundation

extension cef_load_handler_t: CEFObject {}

typealias CEFLoadHandlerMarshaller = CEFMarshaller<CEFLoadHandler, cef_load_handler_t>

extension CEFLoadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_load_handler_t> {
        return CEFLoadHandlerMarshaller.pass(self)
    }
}

extension cef_load_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_loading_state_change = CEFLoadHandler_on_loading_state_change
        on_load_start = CEFLoadHandler_on_load_start
        on_load_end = CEFLoadHandler_on_load_end
        on_load_error = CEFLoadHandler_on_load_error
    }
}
