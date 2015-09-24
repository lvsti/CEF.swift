//
//  EndTracingCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_trace.h.
//

import Foundation

extension cef_end_tracing_callback_t: CEFObject {}

typealias EndTracingCallbackMarshaller = Marshaller<EndTracingCallback, cef_end_tracing_callback_t>

extension EndTracingCallback {
    func toCEF() -> UnsafeMutablePointer<cef_end_tracing_callback_t> {
        return EndTracingCallbackMarshaller.pass(self)
    }
}

extension cef_end_tracing_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_end_tracing_complete = EndTracingCallback_on_end_tracing_complete
    }
}
