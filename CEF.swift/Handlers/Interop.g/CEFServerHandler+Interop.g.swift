//
//  CEFServerHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_server.h.
//

import Foundation

extension cef_server_handler_t: CEFObject {}

typealias CEFServerHandlerMarshaller = CEFMarshaller<CEFServerHandler, cef_server_handler_t>

extension CEFServerHandler {
    func toCEF() -> UnsafeMutablePointer<cef_server_handler_t> {
        return CEFServerHandlerMarshaller.pass(self)
    }
}

extension cef_server_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_server_created = CEFServerHandler_on_server_created
        on_server_destroyed = CEFServerHandler_on_server_destroyed
        on_client_connected = CEFServerHandler_on_client_connected
        on_client_disconnected = CEFServerHandler_on_client_disconnected
        on_http_request = CEFServerHandler_on_http_request
        on_web_socket_request = CEFServerHandler_on_web_socket_request
        on_web_socket_connected = CEFServerHandler_on_web_socket_connected
        on_web_socket_message = CEFServerHandler_on_web_socket_message
    }
}
