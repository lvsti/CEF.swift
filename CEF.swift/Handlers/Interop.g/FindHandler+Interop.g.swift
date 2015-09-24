//
//  FindHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_find_handler.h.
//

import Foundation

extension cef_find_handler_t: CEFObject {}

typealias FindHandlerMarshaller = Marshaller<FindHandler, cef_find_handler_t>

extension FindHandler {
    func toCEF() -> UnsafeMutablePointer<cef_find_handler_t> {
        return FindHandlerMarshaller.pass(self)
    }
}

extension cef_find_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_find_result = FindHandler_on_find_result
    }
}
