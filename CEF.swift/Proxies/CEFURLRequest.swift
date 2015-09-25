//
//  CEFURLRequest.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFURLRequest {
    
    /// Create a new URL request. Only GET, POST, HEAD, DELETE and PUT request
    /// methods are supported. Multiple post data elements are not supported and
    /// elements of type PDE_TYPE_FILE are only supported for requests originating
    /// from the browser process. Requests originating from the render process will
    /// receive the same handling as requests originating from Web content -- if
    /// the response contains Content-Disposition or Mime-Type header values that
    /// would not normally be rendered then the response may receive special
    /// handling inside the browser (for example, via the file download code path
    /// instead of the URL request code path). The |request| object will be marked
    /// as read-only after calling this method. In the browser process if
    /// |request_context| is empty the global request context will be used. In the
    /// render process |request_context| must be empty and the context associated
    /// with the current renderer process' browser will be used.
    public convenience init?(request: CEFRequest, client: CEFURLRequestClient, context: CEFRequestContext? = nil) {
        self.init(ptr: cef_urlrequest_create(request.toCEF(),
                                             client.toCEF(),
                                             context != nil ? context!.toCEF() : nil))
    }
    
    /// Returns the request object used to create this URL request. The returned
    /// object is read-only and should not be modified.
    public var request: CEFRequest {
        let cefReq = cefObject.get_request(cefObjectPtr)
        return CEFRequest.fromCEF(cefReq)!
    }
    
    /// Returns the client.
    public var client: CEFURLRequestClient {
        let cefClient = cefObject.get_client(cefObjectPtr)
        return CEFURLRequestClientMarshaller.take(cefClient)!
    }
    
    /// Returns the request status.
    public var requestStatus: CEFURLRequestStatus {
        let cefStatus = cefObject.get_request_status(cefObjectPtr)
        return CEFURLRequestStatus.fromCEF(cefStatus)
    }

    /// Returns the request error if status is UR_CANCELED or UR_FAILED, or 0
    /// otherwise.
    public var requestError: CEFErrorCode? {
        let cefError = cefObject.get_request_error(cefObjectPtr)
        return cefError.rawValue != 0 ? CEFErrorCode.fromCEF(cefError.rawValue) : nil
    }

    /// Returns the response, or NULL if no response information is available.
    /// Response information will only be available after the upload has completed.
    /// The returned object is read-only and should not be modified.
    public var response: CEFResponse? {
        let cefResp = cefObject.get_response(cefObjectPtr)
        return CEFResponse.fromCEF(cefResp)
    }

    /// Cancel the request.
    public func cancel() {
        cefObject.cancel(cefObjectPtr)
    }

}
