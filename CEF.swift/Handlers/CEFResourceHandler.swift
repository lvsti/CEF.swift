//
//  CEFResourceHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Class used to implement a custom request handler interface. The methods of
// this class will always be called on the IO thread.
///
public protocol CEFResourceHandler {

    ///
    // Begin processing the request. To handle the request return true and call
    // CefCallback::Continue() once the response header information is available
    // (CefCallback::Continue() can also be called from inside this method if
    // header information is available immediately). To cancel the request return
    // false.
    ///
    func processRequest(request: CEFRequest, callback: CEFCallback) -> Bool

    ///
    // Retrieve response header information. If the response length is not known
    // set |response_length| to -1 and ReadResponse() will be called until it
    // returns false. If the response length is known set |response_length|
    // to a positive value and ReadResponse() will be called until it returns
    // false or the specified number of bytes have been read. Use the |response|
    // object to set the mime type, http status code and other optional header
    // values. To redirect the request to a new URL set |redirectUrl| to the new
    // URL.
    ///
    func getResponseHeaders(response: CEFResponse, inout responseLength: Int64?, inout redirectURL: NSURL?)
    
    ///
    // Read response data. If data is available immediately copy up to
    // |bytes_to_read| bytes into |data_out|, set |bytes_read| to the number of
    // bytes copied, and return true. To read the data at a later time set
    // |bytes_read| to 0, return true and call CefCallback::Continue() when the
    // data is available. To indicate response completion return false.
    ///
    func readResponse(buffer: UnsafeMutablePointer<Void>, bufferLength: Int, inout actualLength: Int, callback: CEFCallback) -> Bool
    
    ///
    // Return true if the specified cookie can be sent with the request or false
    // otherwise. If false is returned for any cookie then no cookies will be sent
    // with the request.
    ///
    func canGetCookie(cookie: CEFCookie) -> Bool
    
    ///
    // Return true if the specified cookie returned with the response can be set
    // or false otherwise.
    ///
    func canSetCookie(cookie: CEFCookie) -> Bool
    
    ///
    // Request processing has been canceled.
    ///
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
