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

public enum CEFOnOpenResponseStreamAction {
    /// Handle the request immediately
    case handle
    
    /// Handle the request deferred (resume with callback)
    case handleAsync
    
    /// Cancel the request
    case cancel
}

public enum CEFOnSkipResponseDataAction {
    /// Data is available immediately, associated value shows the number of bytes skipped
    case skip(Int64)

    /// Data will be skipped asynchronously
    case skipAsync
    
    /// Failed to skip the requested amount of bytes
    case failure(CEFErrorCode)
}

public enum CEFOnReadResponseDataAction {
    /// Data is available immediately, associated value shows the number of bytes read
    case read(Int)
    
    /// Data will be provided asynchronously
    case readAsync
    
    /// No bytes left
    case complete
    
    /// Failed to read
    case failure(CEFErrorCode)
}

/// Class used to implement a custom request handler interface. The methods of
/// this class will be called on the IO thread unless otherwise indicated.
/// CEF name: `CefResourceHandler`
public protocol CEFResourceHandler {

    /// Open the response stream. To handle the request immediately set
    /// |handle_request| to true and return true. To decide at a later time set
    /// |handle_request| to false, return true, and execute |callback| to continue
    /// or cancel the request. To cancel the request immediately set
    /// |handle_request| to true and return false. This method will be called in
    /// sequence but not from a dedicated thread. For backwards compatibility set
    /// |handle_request| to false and return false and the ProcessRequest method
    /// will be called.
    /// CEF name: `Open`
    func onOpenResponseStream(request: CEFRequest, callback: CEFCallback) -> CEFOnOpenResponseStreamAction

    /// Begin processing the request. To handle the request return true and call
    /// CefCallback::Continue() once the response header information is available
    /// (CefCallback::Continue() can also be called from inside this method if
    /// header information is available immediately). To cancel the request return
    /// false.
    ///
    /// WARNING: This method is deprecated. Use Open instead.
    /// CEF name: `ProcessRequest`
    @available(*, deprecated, message: "Use onOpenResponseStream instead")
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
    
    /// Skip response data when requested by a Range header. Skip over and discard
    /// |bytes_to_skip| bytes of response data. If data is available immediately
    /// set |bytes_skipped| to the number of bytes skipped and return true. To
    /// read the data at a later time set |bytes_skipped| to 0, return true and
    /// execute |callback| when the data is available. To indicate failure set
    /// |bytes_skipped| to < 0 (e.g. -2 for ERR_FAILED) and return false. This
    /// method will be called in sequence but not from a dedicated thread.
    /// CEF name: `Skip`
    func onSkipResponseData(skipLength: Int64, callback: CEFResourceSkipCallback) -> CEFOnSkipResponseDataAction
    
    /// Read response data. If data is available immediately copy up to
    /// |bytes_to_read| bytes into |data_out|, set |bytes_read| to the number of
    /// bytes copied, and return true. To read the data at a later time keep a
    /// pointer to |data_out|, set |bytes_read| to 0, return true and execute
    /// |callback| when the data is available (|data_out| will remain valid until
    /// the callback is executed). To indicate response completion set |bytes_read|
    /// to 0 and return false. To indicate failure set |bytes_read| to < 0 (e.g. -2
    /// for ERR_FAILED) and return false. This method will be called in sequence
    /// but not from a dedicated thread. For backwards compatibility set
    /// |bytes_read| to -1 and return false and the ReadResponse method will be
    /// called.
    /// CEF name: `Read`
    func onReadResponseData(buffer: UnsafeMutableRawPointer,
                            bufferLength: Int,
                            callback: CEFResourceReadCallback) -> CEFOnReadResponseDataAction

    /// Read response data. If data is available immediately copy up to
    /// |bytes_to_read| bytes into |data_out|, set |bytes_read| to the number of
    /// bytes copied, and return true. To read the data at a later time set
    /// |bytes_read| to 0, return true and call CefCallback::Continue() when the
    /// data is available. To indicate response completion return false.
    ///
    /// WARNING: This method is deprecated. Use Skip and Read instead.
    /// CEF name: `ReadResponse`
    @available(*, deprecated, message: "Use Skip and Read instead")
    func onReadResponse(buffer: UnsafeMutableRawPointer,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction
    
    /// Request processing has been canceled.
    /// CEF name: `Cancel`
    func onRequestCanceled()

}

public extension CEFResourceHandler {
    
    func onOpenResponseStream(request: CEFRequest, callback: CEFCallback) -> CEFOnOpenResponseStreamAction {
        return .cancel
    }

    func onProcessRequest(request: CEFRequest, callback: CEFCallback) -> CEFOnProcessRequestAction {
        return .cancel
    }
    
    func onGetResponseHeaders(response: CEFResponse) -> CEFOnGetResponseHeadersAction {
        return .continueWithUnknownResponseLength
    }
    
    func onSkipResponseData(skipLength: Int64, callback: CEFResourceSkipCallback) -> CEFOnSkipResponseDataAction {
        return .skip(skipLength)
    }

    func onReadResponseData(buffer: UnsafeMutableRawPointer,
                            bufferLength: Int,
                            callback: CEFCallback) -> CEFOnReadResponseDataAction {
        return .complete
    }

    func onReadResponse(buffer: UnsafeMutableRawPointer,
                        bufferLength: Int,
                        callback: CEFCallback) -> CEFOnReadResponseAction {
        return .complete
    }
    
    func onRequestCanceled() {
    }
    
}
