//
//  CEFResourceHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnProcessRequestAction {
    case allow
    case cancel
}

public enum CEFOnGetResponseHeadersAction {
    /// Response length is unknown, ReadResponse() will be called until it
    /// returns false
    case continueWithUnknownResponseLength
    
    /// Response length is known, ReadResponse() will be called until it returns
    /// false or the specified number of bytes have been read
    case continueWithResponseLength(UInt64)
    
    /// Redirect request to the given URL
    case redirect(URL)
    
    /// Indicates an error while setting up the response, call SetError()
    /// on the response object to specify
    case abort
}

public enum CEFOnReadResponseAction {
    /// Data is available immediately, associated value shows the number of bytes read
    case read(Int)
    
    /// Data will be provided asynchronously
    case readAsync
    
    /// No bytes left
    case complete
}

/// Class used to implement a custom request handler interface. The methods of
/// this class will always be called on the IO thread.
/// CEF name: `CefResourceHandler`
public protocol CEFResourceHandler {

    /// Begin processing the request. To handle the request return true and call
    /// CefCallback::Continue() once the response header information is available
    /// (CefCallback::Continue() can also be called from inside this method if
    /// header information is available immediately). To cancel the request return
    /// false.
    /// CEF name: `ProcessRequest`
    func onProcessRequest(request: CEFRequest, callback: CEFCallback) -> CEFOnProcessRequestAction

    /// Retrieve response header information. If the response length is not known
    /// set |response_length| to -1 and ReadResponse() will be called until it
    /// returns false. If the response length is known set |response_length|
    /// to a positive value and ReadResponse() will be called until it returns
    /// false or the specified number of bytes have been read. Use the |response|
    /// object to set the mime type, http status code and other optional header
    /// values. To redirect the request to a new URL set |redirectUrl| to the new
    /// URL. |redirectUrl| can be either a relative or fully qualified URL.
    /// It is also possible to set |response| to a redirect http status code
    /// and pass the new URL via a Location header. Likewise with |redirectUrl| it
    /// is valid to set a relative or fully qualified URL as the Location header
    /// value. If an error occured while setting up the request you can call
    /// SetError() on |response| to indicate the error condition.
    /// CEF name: `GetResponseHeaders`
    func onGetResponseHeaders(response: CEFResponse) -> CEFOnGetResponseHeadersAction
    
    /// Read response data. If data is available immediately copy up to
    /// |bytes_to_read| bytes into |data_out|, set |bytes_read| to the number of
    /// bytes copied, and return true. To read the data at a later time set
    /// |bytes_read| to 0, return true and call CefCallback::Continue() when the
    /// data is available. To indicate response completion return false.
    /// CEF name: `ReadResponse`
    func onReadResponse(buffer: UnsafeMutableRawPointer,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction
    
    /// Return true if the specified cookie can be sent with the request or false
    /// otherwise. If false is returned for any cookie then no cookies will be sent
    /// with the request.
    /// CEF name: `CanGetCookie`
    func canGetCookie(cookie: CEFCookie) -> Bool
    
    /// Return true if the specified cookie returned with the response can be set
    /// or false otherwise.
    /// CEF name: `CanSetCookie`
    func canSetCookie(cookie: CEFCookie) -> Bool
    
    /// Request processing has been canceled.
    /// CEF name: `Cancel`
    func onRequestCanceled()

}

public extension CEFResourceHandler {
    
    func onProcessRequest(request: CEFRequest, callback: CEFCallback) -> CEFOnProcessRequestAction {
        return .cancel
    }
    
    func onGetResponseHeaders(response: CEFResponse) -> CEFOnGetResponseHeadersAction {
        return .continueWithUnknownResponseLength
    }
    
    func onReadResponse(buffer: UnsafeMutableRawPointer,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction {
        return .complete
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
