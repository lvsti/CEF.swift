//
//  CEFResourceHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnProcessRequestAction {
    case Allow
    case Cancel
}

extension CEFOnProcessRequestAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

public enum CEFOnGetResponseHeadersAction {
    /// Response length is unknown, ReadResponse() will be called until it
    /// returns false
    case ContinueWithUnknownResponseLength
    
    /// Response length is known, ReadResponse() will be called until it returns
    /// false or the specified number of bytes have been read
    case ContinueWithResponseLength(UInt64)
    
    /// Redirect request to the given URL
    case Redirect(NSURL)
    
    /// Indicates an error while setting up the response, call SetError()
    /// on the response object to specify
    case Abort
}

public enum CEFOnReadResponseAction {
    /// Data is available immediately, associated value shows the number of bytes read
    case Read(Int)
    
    /// Data will be provided asynchronously
    case ReadAsync
    
    /// No bytes left
    case Complete
}

extension CEFOnReadResponseAction: BooleanType {
    public var boolValue: Bool {
        switch self {
        case .Complete: return false
        default: return true
        }
    }
}

/// Class used to implement a custom request handler interface. The methods of
/// this class will always be called on the IO thread.
public protocol CEFResourceHandler {

    /// Begin processing the request. To handle the request return true and call
    /// CefCallback::Continue() once the response header information is available
    /// (CefCallback::Continue() can also be called from inside this method if
    /// header information is available immediately). To cancel the request return
    /// false.
    func onProcessRequest(request: CEFRequest, callback: CEFCallback) -> CEFOnProcessRequestAction

    /// Retrieve response header information. If the response length is not known
    /// set |response_length| to -1 and ReadResponse() will be called until it
    /// returns false. If the response length is known set |response_length|
    /// to a positive value and ReadResponse() will be called until it returns
    /// false or the specified number of bytes have been read. Use the |response|
    /// object to set the mime type, http status code and other optional header
    /// values. To redirect the request to a new URL set |redirectUrl| to the new
    /// URL. If an error occured while setting up the request you can call
    /// SetError() on |response| to indicate the error condition.
    func onGetResponseHeaders(response: CEFResponse) -> CEFOnGetResponseHeadersAction
    
    /// Read response data. If data is available immediately copy up to
    /// |bytes_to_read| bytes into |data_out|, set |bytes_read| to the number of
    /// bytes copied, and return true. To read the data at a later time set
    /// |bytes_read| to 0, return true and call CefCallback::Continue() when the
    /// data is available. To indicate response completion return false.
    func onReadResponse(buffer: UnsafeMutablePointer<Void>,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction
    
    /// Return true if the specified cookie can be sent with the request or false
    /// otherwise. If false is returned for any cookie then no cookies will be sent
    /// with the request.
    func canGetCookie(cookie: CEFCookie) -> Bool
    
    /// Return true if the specified cookie returned with the response can be set
    /// or false otherwise.
    func canSetCookie(cookie: CEFCookie) -> Bool
    
    /// Request processing has been canceled.
    func onRequestCanceled()

}

public extension CEFResourceHandler {
    
    func onProcessRequest(request: CEFRequest, callback: CEFCallback) -> CEFOnProcessRequestAction {
        return .Cancel
    }
    
    func onGetResponseHeaders(response: CEFResponse) -> CEFOnGetResponseHeadersAction {
        return .ContinueWithUnknownResponseLength
    }
    
    func onReadResponse(buffer: UnsafeMutablePointer<Void>,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction {
        return .Complete
    }
    
    func canGetCookie(cookie: CEFCookie) -> Bool {
        return true
    }
    
    func canSetCookie(cookie: CEFCookie) -> Bool {
        return true
    }
    
    func onRequestCanceled() {
    }
    
}
