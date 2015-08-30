//
//  CEFV8Handler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8handler_t: CEFObject {}

typealias CEFV8HandlerMarshaller = CEFMarshaller<CEFV8Handler, cef_v8handler_t>

extension CEFV8Handler {
    func toCEF() -> UnsafeMutablePointer<cef_v8handler_t> {
        return CEFV8HandlerMarshaller.pass(self)
    }
}

extension cef_v8handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        execute = CEFV8Handler_execute
    }
}
