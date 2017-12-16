//
//  CEFServerHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 12. 16..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFServerHandler_on_server_created(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                        server: UnsafeMutablePointer<cef_server_t>?) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onServerCreated(server: CEFServer.fromCEF(server)!)
}

func CEFServerHandler_on_server_destroyed(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                          server: UnsafeMutablePointer<cef_server_t>?) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onServerDestroyed(server: CEFServer.fromCEF(server)!)
}

func CEFServerHandler_on_client_connected(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                          server: UnsafeMutablePointer<cef_server_t>?,
                                          connectionID: Int32) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onClientConnected(server: CEFServer.fromCEF(server)!, connectionID: CEFServer.ConnectionID(connectionID))
}

func CEFServerHandler_on_client_disconnected(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                             server: UnsafeMutablePointer<cef_server_t>?,
                                             connectionID: Int32) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onClientDisconnected(server: CEFServer.fromCEF(server)!, connectionID: CEFServer.ConnectionID(connectionID))
}

func CEFServerHandler_on_http_request(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                      server: UnsafeMutablePointer<cef_server_t>?,
                                      connectionID: Int32,
                                      address: UnsafePointer<cef_string_t>?,
                                      request: UnsafeMutablePointer<cef_request_t>?) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onHTTPRequest(server: CEFServer.fromCEF(server)!,
                      connectionID: CEFServer.ConnectionID(connectionID),
                      clientAddress: CEFStringToSwiftString(address!.pointee),
                      request: CEFRequest.fromCEF(request)!)
}

func CEFServerHandler_on_web_socket_request(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                            server: UnsafeMutablePointer<cef_server_t>?,
                                            connectionID: Int32,
                                            address: UnsafePointer<cef_string_t>?,
                                            request: UnsafeMutablePointer<cef_request_t>?,
                                            callback: UnsafeMutablePointer<cef_callback_t>?) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onWebSocketRequest(server: CEFServer.fromCEF(server)!,
                           connectionID: CEFServer.ConnectionID(connectionID),
                           clientAddress: CEFStringToSwiftString(address!.pointee),
                           request: CEFRequest.fromCEF(request)!,
                           callback: CEFCallback.fromCEF(callback)!)
}

func CEFServerHandler_on_web_socket_connected(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                              server: UnsafeMutablePointer<cef_server_t>?,
                                              connectionID: Int32) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onWebSocketConnected(server: CEFServer.fromCEF(server)!,
                             connectionID: CEFServer.ConnectionID(connectionID))
}

func CEFServerHandler_on_web_socket_message(ptr: UnsafeMutablePointer<cef_server_handler_t>?,
                                            server: UnsafeMutablePointer<cef_server_t>?,
                                            connectionID: Int32,
                                            buffer: UnsafeRawPointer?,
                                            size: size_t) {
    guard let obj = CEFServerHandlerMarshaller.get(ptr) else {
        return
    }

    let data: Data
    if let buffer = buffer, size > 0 {
        data = Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: buffer),
                    count: Int(size),
                    deallocator: .none)
    }
    else {
        data = Data()
    }
    
    obj.onWebSocketMessage(server: CEFServer.fromCEF(server)!,
                           connectionID: CEFServer.ConnectionID(connectionID),
                           data: data)
}
