//
//  RequestHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_handler.h.
//

import Foundation

extension cef_request_handler_t: CEFObject {}

typealias RequestHandlerMarshaller = Marshaller<RequestHandler, cef_request_handler_t>

extension RequestHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_handler_t> {
        return RequestHandlerMarshaller.pass(self)
    }
}

extension cef_request_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_browse = RequestHandler_on_before_browse
        on_open_urlfrom_tab = RequestHandler_on_open_urlfrom_tab
        on_before_resource_load = RequestHandler_on_before_resource_load
        get_resource_handler = RequestHandler_get_resource_handler
        on_resource_redirect = RequestHandler_on_resource_redirect
        on_resource_response = RequestHandler_on_resource_response
        get_auth_credentials = RequestHandler_get_auth_credentials
        on_quota_request = RequestHandler_on_quota_request
        on_protocol_execution = RequestHandler_on_protocol_execution
        on_certificate_error = RequestHandler_on_certificate_error
        on_before_plugin_load = RequestHandler_on_before_plugin_load
        on_plugin_crashed = RequestHandler_on_plugin_crashed
        on_render_view_ready = RequestHandler_on_render_view_ready
        on_render_process_terminated = RequestHandler_on_render_process_terminated
    }
}
