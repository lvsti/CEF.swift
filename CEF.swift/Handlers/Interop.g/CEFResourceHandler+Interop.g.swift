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
        process_request = CEFResourceHandler_process_request
        get_response_headers = CEFResourceHandler_get_response_headers
        read_response = CEFResourceHandler_read_response
        can_get_cookie = CEFResourceHandler_can_get_cookie
        can_set_cookie = CEFResourceHandler_can_set_cookie
        cancel = CEFResourceHandler_cancel
    }
}
