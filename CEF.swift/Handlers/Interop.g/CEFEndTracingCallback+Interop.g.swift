//
//  CEFEndTracingCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_trace.h.
//

import Foundation

extension cef_end_tracing_callback_t: CEFObject {}

typealias CEFEndTracingCallbackMarshaller = CEFMarshaller<CEFEndTracingCallback, cef_end_tracing_callback_t>

extension cef_end_tracing_callback_t {
    func toCEF() -> UnsafeMutablePointer<cef_end_tracing_callback_t> {
        return CEFEndTracingCallbackMarshaller.pass(self)
    }
}

extension cef_end_tracing_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_end_tracing_complete = CEFEndTracingCallback_on_end_tracing_complete
    }
}
