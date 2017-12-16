//
//  CEFServer.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 12. 16..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFServer {
    
    typealias ConnectionID = Int
    
    /// Create a new server that binds to |address| and |port|. |address| must be a
    /// valid IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1) and |port| must be a
    /// port number outside of the reserved range (e.g. between 1025 and 65535 on
    /// most platforms). |backlog| is the maximum number of pending connections.
    /// A new thread will be created for each CreateServer call (the "dedicated
    /// server thread"). It is therefore recommended to use a different
    /// CefServerHandler instance for each CreateServer call to avoid thread safety
    /// issues in the CefServerHandler implementation. The
    /// CefServerHandler::OnServerCreated method will be called on the dedicated
    /// server thread to report success or failure. See
    /// CefServerHandler::OnServerCreated documentation for a description of server
    /// lifespan.
    /// CEF name: `CreateServer`
    public static func create(address: String, port: UInt16, backlogSize: Int, handler: CEFServerHandler) {
        let cefStr = CEFStringPtrCreateFromSwiftString(address)
        defer { CEFStringPtrRelease(cefStr) }
        cef_server_create(cefStr, port, Int32(backlogSize), handler.toCEF())
    }
    
    /// Returns the task runner for the dedicated server thread.
    /// CEF name: `GetTaskRunner`
    public var taskRunner: CEFTaskRunner {
        let cefPtr = cefObject.get_task_runner(cefObjectPtr)
        return CEFTaskRunner.fromCEF(cefPtr)!
    }
    
    /// Stop the server and shut down the dedicated server thread. See
    /// CefServerHandler::OnServerCreated documentation for a description of
    /// server lifespan.
    /// CEF name: `Shutdown`
    public func shutDown() {
        cefObject.shutdown(cefObjectPtr)
    }
    
    /// Returns true if the server is currently running and accepting incoming
    /// connections. See CefServerHandler::OnServerCreated documentation for a
    /// description of server lifespan. This method must be called on the dedicated
    /// server thread.
    /// CEF name: `IsRunning`
    public var isRunning: Bool {
        return cefObject.is_running(cefObjectPtr) != 0
    }
    
    /// Returns the server address including the port number.
    /// CEF name: `GetAddress`
    public var addressString: String {
        let cefStr = cefObject.get_address(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStr) }
        return CEFStringToSwiftString(cefStr!.pointee)
    }
    
    /// Returns true if the server currently has a connection. This method must be
    /// called on the dedicated server thread.
    /// CEF name: `HasConnection`
    public var hasConnection: Bool {
        return cefObject.has_connection(cefObjectPtr) != 0
    }
    
    /// Returns true if |connection_id| represents a valid connection. This method
    /// must be called on the dedicated server thread.
    /// CEF name: `IsValidConnection`
    public func isValidConnection(id: ConnectionID) -> Bool {
        return cefObject.is_valid_connection(cefObjectPtr, Int32(id)) != 0
    }
    
    /// Send an HTTP 200 "OK" response to the connection identified by
    /// |connection_id|. |content_type| is the response content type (e.g.
    /// "text/html"), |data| is the response content, and |data_size| is the size
    /// of |data| in bytes. The contents of |data| will be copied. The connection
    /// will be closed automatically after the response is sent.
    /// CEF name: `SendHttp200Response`
    public func sendHTTP200Response(id: ConnectionID, contentType: String, data: Data) {
        let cefStr = CEFStringPtrCreateFromSwiftString(contentType)
        defer { CEFStringPtrRelease(cefStr) }
        data.withUnsafeBytes { buffer in
            cefObject.send_http200response(cefObjectPtr, Int32(id), cefStr, buffer, data.count)
        }
    }
    
    /// Send an HTTP 404 "Not Found" response to the connection identified by
    /// |connection_id|. The connection will be closed automatically after the
    /// response is sent.
    /// CEF name: `SendHttp404Response`
    public func sendHTTP404Response(id: ConnectionID) {
        cefObject.send_http404response(cefObjectPtr, Int32(id))
    }
    
    /// Send an HTTP 500 "Internal Server Error" response to the connection
    /// identified by |connection_id|. |error_message| is the associated error
    /// message. The connection will be closed automatically after the response is
    /// sent.
    /// CEF name: `SendHttp500Response`
    public func sendHTTP500Response(id: ConnectionID, message: String) {
        let cefStr = CEFStringPtrCreateFromSwiftString(message)
        defer { CEFStringPtrRelease(cefStr) }
        cefObject.send_http500response(cefObjectPtr, Int32(id), cefStr)
    }
    
    /// Send a custom HTTP response to the connection identified by
    /// |connection_id|. |response_code| is the HTTP response code sent in the
    /// status line (e.g. 200), |content_type| is the response content type sent
    /// as the "Content-Type" header (e.g. "text/html"), |content_length| is the
    /// expected content length, and |extra_headers| is the map of extra response
    /// headers. If |content_length| is >= 0 then the "Content-Length" header will
    /// be sent. If |content_length| is 0 then no content is expected and the
    /// connection will be closed automatically after the response is sent. If
    /// |content_length| is < 0 then no "Content-Length" header will be sent and
    /// the client will continue reading until the connection is closed. Use the
    /// SendRawData method to send the content, if applicable, and call
    /// CloseConnection after all content has been sent.
    /// CEF name: `SendHttpResponse`
    public func sendHTTPResponse(id: ConnectionID,
                                 statusCode: Int,
                                 contentType: String,
                                 contentLength: UInt64,
                                 headers: [String: [String]]? = nil) {
        let cefStr = CEFStringPtrCreateFromSwiftString(contentType)
        defer { CEFStringPtrRelease(cefStr) }

        let cefHeaderMap = headers != nil ? CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headers!) : nil
        defer {
            if cefHeaderMap != nil {
                cef_string_multimap_free(cefHeaderMap)
            }
        }
        
        cefObject.send_http_response(cefObjectPtr,
                                     Int32(id),
                                     Int32(statusCode),
                                     cefStr,
                                     int64(contentLength),
                                     cefHeaderMap)
    }
    
    /// Send raw data directly to the connection identified by |connection_id|.
    /// |data| is the raw data and |data_size| is the size of |data| in bytes.
    /// The contents of |data| will be copied. No validation of |data| is
    /// performed internally so the client should be careful to send the amount
    /// indicated by the "Content-Length" header, if specified. See
    /// SendHttpResponse documentation for intended usage.
    /// CEF name: `SendRawData`
    public func sendRawData(id: ConnectionID, data: Data) {
        data.withUnsafeBytes { buffer in
            cefObject.send_raw_data(cefObjectPtr, Int32(id), buffer, data.count)
        }
    }
    
    /// Close the connection identified by |connection_id|. See SendHttpResponse
    /// documentation for intended usage.
    /// CEF name: `CloseConnection`
    public func closeConnection(id: ConnectionID) {
        cefObject.close_connection(cefObjectPtr, Int32(id))
    }
    
    ///
    // Send a WebSocket message to the connection identified by |connection_id|.
    // |data| is the response content and |data_size| is the size of |data| in
    // bytes. The contents of |data| will be copied. See
    // CefServerHandler::OnWebSocketRequest documentation for intended usage.
    /// CEF name: `SendWebSocketMessage`
    public func sendWebSocketMessage(id: ConnectionID, data: Data) {
        data.withUnsafeBytes { buffer in
            cefObject.send_web_socket_message(cefObjectPtr, Int32(id), buffer, data.count)
        }
    }

}
