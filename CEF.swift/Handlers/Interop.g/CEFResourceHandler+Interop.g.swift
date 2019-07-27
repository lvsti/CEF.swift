//
//  CEFResourceHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_handler.h.
//

import Foundation

extension cef_resource_handler_t: CEFObject {}

typealias CEFResourceHandlerMarshaller = CEFMarshaller<CEFResourceHandler, cef_resource_handler_t>

extension CEFResourceHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_handler_t> {
        return CEFResourceHandlerMarshaller.pass(self)
    }
}

extension cef_resource_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        open = CEFResourceHandler_open
        process_request = CEFResourceHandler_process_request
        get_response_headers = CEFResourceHandler_get_response_headers
        skip = CEFResourceHandler_skip
        read = CEFResourceHandler_read
        read_response = CEFResourceHandler_read_response
        cancel = CEFResourceHandler_cancel
    }
}
