//
//  CEFServer+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_server.h.
//

import Foundation

extension cef_server_t: CEFObject {}

/// Class representing a server that supports HTTP and WebSocket requests. Server
/// capacity is limited and is intended to handle only a small number of
/// simultaneous connections (e.g. for communicating between applications on
/// localhost). The methods of this class are safe to call from any thread in the
/// brower process unless otherwise indicated.
/// CEF name: `CefServer`
public final class CEFServer: CEFProxy<cef_server_t> {
    override init?(ptr: UnsafeMutablePointer<cef_server_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_server_t>?) -> CEFServer? {
        return CEFServer(ptr: ptr)
    }
}

