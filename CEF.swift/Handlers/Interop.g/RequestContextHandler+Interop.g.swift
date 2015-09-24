//
//  RequestContextHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_context_handler.h.
//

import Foundation

extension cef_request_context_handler_t: CEFObject {}

typealias RequestContextHandlerMarshaller = Marshaller<RequestContextHandler, cef_request_context_handler_t>

extension RequestContextHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_context_handler_t> {
        return RequestContextHandlerMarshaller.pass(self)
    }
}

extension cef_request_context_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        get_cookie_manager = RequestContextHandler_get_cookie_manager
    }
}
