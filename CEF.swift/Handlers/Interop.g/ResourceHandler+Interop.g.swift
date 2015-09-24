//
//  ResourceHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_handler.h.
//

import Foundation

extension cef_resource_handler_t: CEFObject {}

typealias ResourceHandlerMarshaller = Marshaller<ResourceHandler, cef_resource_handler_t>

extension ResourceHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_handler_t> {
        return ResourceHandlerMarshaller.pass(self)
    }
}

extension cef_resource_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        process_request = ResourceHandler_process_request
        get_response_headers = ResourceHandler_get_response_headers
        read_response = ResourceHandler_read_response
        can_get_cookie = ResourceHandler_can_get_cookie
        can_set_cookie = ResourceHandler_can_set_cookie
        cancel = ResourceHandler_cancel
    }
}
