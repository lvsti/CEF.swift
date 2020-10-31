//
//  CEFURLRequest.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFURLRequest {
    
    /// Create a new URL request that is not associated with a specific browser or
    /// frame. Use CefFrame::CreateURLRequest instead if you want the request to
    /// have this association, in which case it may be handled differently (see
    /// documentation on that method). A request created with this method may only
    /// originate from the browser process, and will behave as follows:
    ///   - It may be intercepted by the client via CefResourceRequestHandler or
    ///     CefSchemeHandlerFactory.
    ///   - POST data may only contain only a single element of type PDE_TYPE_FILE
    ///     or PDE_TYPE_BYTES.
    ///   - If |request_context| is empty the global request context will be used.
    ///
    /// The |request| object will be marked as read-only after calling this method.
    /// CEF name: `Create`
    public convenience init?(request: CEFRequest, client: CEFURLRequestClient, context: CEFRequestContext? = nil) {
        self.init(ptr: cef_urlrequest_create(request.toCEF(),
                                             client.toCEF(),
                                             context != nil ? context!.toCEF() : nil))
    }
    
    /// Returns the request object used to create this URL request. The returned
    /// object is read-only and should not be modified.
    /// CEF name: `GetRequest`
    public var request: CEFRequest {
        let cefReq = cefObject.get_request(cefObjectPtr)
        return CEFRequest.fromCEF(cefReq)!
    }
    
    /// Returns the client.
    /// CEF name: `GetClient`
    public var client: CEFURLRequestClient {
        let cefClient = cefObject.get_client(cefObjectPtr)
        return CEFURLRequestClientMarshaller.take(cefClient)!
    }
    
    /// Returns the request status.
    /// CEF name: `GetRequestStatus`
    public var requestStatus: CEFURLRequestStatus {
        let cefStatus = cefObject.get_request_status(cefObjectPtr)
        return CEFURLRequestStatus.fromCEF(cefStatus)
    }

    /// Returns the request error if status is UR_CANCELED or UR_FAILED, or 0
    /// otherwise.
    /// CEF name: `GetRequestError`
    public var requestError: CEFErrorCode? {
        let cefError = cefObject.get_request_error(cefObjectPtr)
        return cefError.rawValue != 0 ? CEFErrorCode.fromCEF(cefError.rawValue) : nil
    }

    /// Returns the response, or NULL if no response information is available.
    /// Response information will only be available after the upload has completed.
    /// The returned object is read-only and should not be modified.
    /// CEF name: `GetResponse`
    public var response: CEFResponse? {
        let cefResp = cefObject.get_response(cefObjectPtr)
        return CEFResponse.fromCEF(cefResp)
    }
    
    /// Returns true if the response body was served from the cache. This includes
    /// responses for which revalidation was required.
    /// CEF name: `ResponseWasCached`
    public var responseWasCached: Bool {
        return cefObject.response_was_cached(cefObjectPtr) != 0
    }

    /// Cancel the request.
    /// CEF name: `Cancel`
    public func cancel() {
        cefObject.cancel(cefObjectPtr)
    }

}
