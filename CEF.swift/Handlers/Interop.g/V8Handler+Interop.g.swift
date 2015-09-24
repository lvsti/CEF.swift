//
//  V8Handler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8handler_t: CEFObject {}

typealias V8HandlerMarshaller = Marshaller<V8Handler, cef_v8handler_t>

extension V8Handler {
    func toCEF() -> UnsafeMutablePointer<cef_v8handler_t> {
        return V8HandlerMarshaller.pass(self)
    }
}

extension cef_v8handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        execute = V8Handler_execute
    }
}
