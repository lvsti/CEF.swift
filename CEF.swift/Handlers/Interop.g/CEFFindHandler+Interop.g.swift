//
//  CEFFindHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_find_handler.h.
//

import Foundation

extension cef_find_handler_t: CEFObject {}

typealias CEFFindHandlerMarshaller = CEFMarshaller<CEFFindHandler, cef_find_handler_t>

extension cef_find_handler_t {
    func toCEF() -> UnsafeMutablePointer<cef_find_handler_t> {
        return CEFFindHandlerMarshaller.pass(self)
    }
}

extension cef_find_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_find_result = CEFFindHandler_on_find_result
    }
}
