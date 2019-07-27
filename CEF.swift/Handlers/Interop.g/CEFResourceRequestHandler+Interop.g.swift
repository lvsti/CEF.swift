//
//  CEFResourceRequestHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_request_handler.h.
//

import Foundation

extension cef_resource_request_handler_t: CEFObject {}

typealias CEFResourceRequestHandlerMarshaller = CEFMarshaller<CEFResourceRequestHandler, cef_resource_request_handler_t>

extension CEFResourceRequestHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_request_handler_t> {
        return CEFResourceRequestHandlerMarshaller.pass(self)
    }
}

extension cef_resource_request_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_cookie_access_filter = CEFResourceRequestHandler_get_cookie_access_filter
        on_before_resource_load = CEFResourceRequestHandler_on_before_resource_load
        get_resource_handler = CEFResourceRequestHandler_get_resource_handler
        on_resource_redirect = CEFResourceRequestHandler_on_resource_redirect
        on_resource_response = CEFResourceRequestHandler_on_resource_response
        get_resource_response_filter = CEFResourceRequestHandler_get_resource_response_filter
        on_resource_load_complete = CEFResourceRequestHandler_on_resource_load_complete
        on_protocol_execution = CEFResourceRequestHandler_on_protocol_execution
    }
}
