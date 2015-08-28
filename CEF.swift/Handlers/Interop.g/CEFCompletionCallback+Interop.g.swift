//
//  CEFCompletionCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_callback.h.
//

import Foundation

extension cef_completion_callback_t: CEFObject {}

typealias CEFCompletionCallbackMarshaller = CEFMarshaller<CEFCompletionCallback, cef_completion_callback_t>

extension cef_completion_callback_t {
    func toCEF() -> UnsafeMutablePointer<cef_completion_callback_t> {
        return CEFCompletionCallbackMarshaller.pass(self)
    }
}

extension cef_completion_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CEFCompletionCallback_on_complete
    }
}
