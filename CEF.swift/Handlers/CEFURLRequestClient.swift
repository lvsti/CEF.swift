//
//  CEFURLRequestClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface that should be implemented by the CefURLRequest client. The
// methods of this class will be called on the same thread that created the
// request unless otherwise documented.
///
public protocol CEFURLRequestClient {
    ///
    // Notifies the client that the request has completed. Use the
    // CefURLRequest::GetRequestStatus method to determine if the request was
    // successful or not.
    ///
    func onRequestComplete(request: CEFURLRequest)
    
    ///
    // Notifies the client of upload progress. |current| denotes the number of
    // bytes sent so far and |total| is the total size of uploading data (or -1 if
    // chunked upload is enabled). This method will only be called if the
    // UR_FLAG_REPORT_UPLOAD_PROGRESS flag is set on the request.
    ///
    func onUploadProgress(request: CEFURLRequest, sentCount: Int64, totalCount: Int64)
    
    ///
    // Notifies the client of download progress. |current| denotes the number of
    // bytes received up to the call and |total| is the expected total size of the
    // response (or -1 if not determined).
    ///
    func onDownloadProgress(request: CEFURLRequest, receivedCount: Int64, totalCount: Int64)
    
    ///
    // Called when some part of the response is read. |data| contains the current
    // bytes received since the last call. This method will not be called if the
    // UR_FLAG_NO_DOWNLOAD_DATA flag is set on the request.
    ///
    func onDownloadData(request: CEFURLRequest, chunk: NSData)
    
    ///
    // Called on the IO thread when the browser needs credentials from the user.
    // |isProxy| indicates whether the host is a proxy server. |host| contains the
    // hostname and |port| contains the port number. Return true to continue the
    // request and call CefAuthCallback::Continue() when the authentication
    // information is available. Return false to cancel the request. This method
    // will only be called for requests initiated from the browser process.
    ///
    func getAuthCredentials(isProxy: Bool,
                            host: String,
                            port: UInt16,
                            realm: String?,
                            scheme: String,
                            callback: CEFAuthCallback) -> Bool
}

public extension CEFURLRequestClient {
    func onRequestComplete(request: CEFURLRequest) {
    }

    func onUploadProgress(request: CEFURLRequest, sentCount: Int64, totalCount: Int64) {
    }
    
    func onDownloadProgress(request: CEFURLRequest, receivedCount: Int64, totalCount: Int64) {
    }
    
    func onDownloadData(request: CEFURLRequest, chunk: NSData) {
    }
    
    func getAuthCredentials(isProxy: Bool,
                            host: String,
                            port: UInt16,
                            realm: String?,
                            scheme: String,
                            callback: CEFAuthCallback) -> Bool {
        return false
    }
}

