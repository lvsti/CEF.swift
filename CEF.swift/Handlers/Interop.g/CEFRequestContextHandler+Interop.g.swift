//
//  CEFRequestContextHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_context_handler.h.
//

import Foundation

extension cef_request_context_handler_t: CEFObject {}

typealias CEFRequestContextHandlerMarshaller = CEFMarshaller<CEFRequestContextHandler, cef_request_context_handler_t>

extension CEFRequestContextHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_context_handler_t> {
        return CEFRequestContextHandlerMarshaller.pass(self)
    }
}

extension cef_request_context_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_context_initialized = CEFRequestContextHandler_on_request_context_initialized
        on_before_plugin_load = CEFRequestContextHandler_on_before_plugin_load
        get_resource_request_handler = CEFRequestContextHandler_get_resource_request_handler
    }
}
