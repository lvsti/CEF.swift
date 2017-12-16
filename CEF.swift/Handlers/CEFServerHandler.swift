//
//  CEFServerHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 12. 16..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to handle HTTP server requests. A new thread will be
/// created for each CefServer::CreateServer call (the "dedicated server
/// thread"), and the methods of this class will be called on that thread. It is
/// therefore recommended to use a different CefServerHandler instance for each
/// CefServer::CreateServer call to avoid thread safety issues in the
/// CefServerHandler implementation.
/// CEF name: `CefServerHandler`
public protocol CEFServerHandler {
    
    /// Called when |server| is created. If the server was started successfully
    /// then CefServer::IsRunning will return true. The server will continue
    /// running until CefServer::Shutdown is called, after which time
    /// OnServerDestroyed will be called. If the server failed to start then
    /// OnServerDestroyed will be called immediately after this method returns.
    /// CEF name: `OnServerCreated`
    func onServerCreated(server: CEFServer)
    
    /// Called when |server| is destroyed. The server thread will be stopped after
    /// this method returns. The client should release any references to |server|
    /// when this method is called. See OnServerCreated documentation for a
    /// description of server lifespan.
    /// CEF name: `OnServerDestroyed`
    func onServerDestroyed(server: CEFServer)
    
    /// Called when a client connects to |server|. |connection_id| uniquely
    /// identifies the connection. Each call to this method will have a matching
    /// call to OnClientDisconnected.
    /// CEF name: `OnClientConnected`
    func onClientConnected(server: CEFServer, connectionID: CEFServer.ConnectionID)
    
    /// Called when a client disconnects from |server|. |connection_id| uniquely
    /// identifies the connection. The client should release any data associated
    /// with |connection_id| when this method is called and |connection_id| should
    /// no longer be passed to CefServer methods. Disconnects can originate from
    /// either the client or the server. For example, the server will disconnect
    /// automatically after a CefServer::SendHttpXXXResponse method is called.
    /// CEF name: `OnClientDisconnected`
    func onClientDisconnected(server: CEFServer, connectionID: CEFServer.ConnectionID)
    
    /// Called when |server| receives an HTTP request. |connection_id| uniquely
    /// identifies the connection, |client_address| is the requesting IPv4 or IPv6
    /// client address including port number, and |request| contains the request
    /// contents (URL, method, headers and optional POST data). Call CefServer
    /// methods either synchronously or asynchronusly to send a response.
    /// CEF name: `OnHttpRequest`
    func onHTTPRequest(server: CEFServer,
                       connectionID: CEFServer.ConnectionID,
                       clientAddress: String,
                       request: CEFRequest)
    
    /// Called when |server| receives a WebSocket request. |connection_id| uniquely
    /// identifies the connection, |client_address| is the requesting IPv4 or
    /// IPv6 client address including port number, and |request| contains the
    /// request contents (URL, method, headers and optional POST data). Execute
    /// |callback| either synchronously or asynchronously to accept or decline the
    /// WebSocket connection. If the request is accepted then OnWebSocketConnected
    /// will be called after the WebSocket has connected and incoming messages will
    /// be delivered to the OnWebSocketMessage callback. If the request is declined
    /// then the client will be disconnected and OnClientDisconnected will be
    /// called. Call the CefServer::SendWebSocketMessage method after receiving the
    /// OnWebSocketConnected callback to respond with WebSocket messages.
    /// CEF name: `OnWebSocketRequest`
    func onWebSocketRequest(server: CEFServer,
                            connectionID: CEFServer.ConnectionID,
                            clientAddress: String,
                            request: CEFRequest,
                            callback: CEFCallback)
    
    /// Called after the client has accepted the WebSocket connection for |server|
    /// and |connection_id| via the OnWebSocketRequest callback. See
    /// OnWebSocketRequest documentation for intended usage.
    /// CEF name: `OnWebSocketConnected`
    func onWebSocketConnected(server: CEFServer, connectionID: CEFServer.ConnectionID)
    
    /// Called when |server| receives an WebSocket message. |connection_id|
    /// uniquely identifies the connection, |data| is the message content and
    /// |data_size| is the size of |data| in bytes. Do not keep a reference to
    /// |data| outside of this method. See OnWebSocketRequest documentation for
    /// intended usage.
    /// CEF name: `OnWebSocketMessage`
    func onWebSocketMessage(server: CEFServer, connectionID: CEFServer.ConnectionID, data: Data)

}

public extension CEFServerHandler {

    func onServerCreated(server: CEFServer) {
    }
    
    func onServerDestroyed(server: CEFServer) {
    }
    
    func onClientConnected(server: CEFServer, connectionID: CEFServer.ConnectionID) {
    }
    
    func onClientDisconnected(server: CEFServer, connectionID: CEFServer.ConnectionID) {
    }
    
    func onHTTPRequest(server: CEFServer,
                       connectionID: CEFServer.ConnectionID,
                       clientAddress: String,
                       request: CEFRequest) {
    }
    
    func onWebSocketRequest(server: CEFServer,
                            connectionID: CEFServer.ConnectionID,
                            clientAddress: String,
                            request: CEFRequest,
                            callback: CEFCallback) {
    }
    
    func onWebSocketConnected(server: CEFServer, connectionID: CEFServer.ConnectionID) {
    }
    
    func onWebSocketMessage(server: CEFServer, connectionID: CEFServer.ConnectionID, data: Data) {
    }

}
