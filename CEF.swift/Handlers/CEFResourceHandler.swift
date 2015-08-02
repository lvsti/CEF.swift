//
//  CEFResourceHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFResourceHandler {

    func processRequest(request: CEFRequest, callback: CEFCallback) -> Bool
    func getResponseHeaders(response: CEFResponse, inout responseLength: Int64?, inout redirectURL: NSURL?)
    func readResponse(buffer: UnsafeMutablePointer<Void>, bufferLength: Int, inout actualLength: Int, callback: CEFCallback) -> Bool
    func canGetCookie(cookie: CEFCookie) -> Bool
    func canSetCookie(cookie: CEFCookie) -> Bool
    func cancel()

}

public extension CEFResourceHandler {
    
    func processRequest(request: CEFRequest, callback: CEFCallback) -> Bool {
        return false
    }
    
    func getResponseHeaders(response: CEFResponse, inout responseLength: Int64?, inout redirectURL: NSURL?) {
    }
    
    func readResponse(buffer: UnsafeMutablePointer<Void>, bufferLength: Int, inout actualLength: Int, callback: CEFCallback) -> Bool {
        return false
    }
    
    func canGetCookie(cookie: CEFCookie) -> Bool {
        return true
    }
    
    func canSetCookie(cookie: CEFCookie) -> Bool {
        return true
    }
    
    func cancel() {
    }
    
}
