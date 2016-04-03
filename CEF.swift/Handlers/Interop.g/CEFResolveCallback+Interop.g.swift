//
//  CEFResolveCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_context.h.
//

import Foundation

extension cef_resolve_callback_t: CEFObject {}

typealias CEFResolveCallbackMarshaller = CEFMarshaller<CEFResolveCallback, cef_resolve_callback_t>

extension CEFResolveCallback {
    func toCEF() -> UnsafeMutablePointer<cef_resolve_callback_t> {
        return CEFResolveCallbackMarshaller.pass(self)
    }
}

extension cef_resolve_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_resolve_completed = CEFResolveCallback_on_resolve_completed
    }
}
