//
//  CompletionCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_callback.h.
//

import Foundation

extension cef_completion_callback_t: CEFObject {}

typealias CompletionCallbackMarshaller = Marshaller<CompletionCallback, cef_completion_callback_t>

extension CompletionCallback {
    func toCEF() -> UnsafeMutablePointer<cef_completion_callback_t> {
        return CompletionCallbackMarshaller.pass(self)
    }
}

extension cef_completion_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CompletionCallback_on_complete
    }
}
