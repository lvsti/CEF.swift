//
//  CEFResourceRequestHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 27..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnResourceResponseAction {
    case continueLoading
    case redirect
    case retry
}

public enum CEFOnProtocolExecutionAction {
    case allow
    case cancel
}

/// Implement this interface to handle events related to browser requests. The
/// methods of this class will be called on the IO thread unless otherwise
/// indicated.
/// CEF name: `CefResourceRequestHandler`
public protocol CEFResourceRequestHandler {
    
    /// Called on the IO thread before a resource request is loaded. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. To optionally
    /// filter cookies for the request return a CefCookieAccessFilter object. The
    /// |request| object cannot not be modified in this callback.
    /// CEF name: `GetCookieAccessFilter`
    func cookieAccessFilter(browser: CEFBrowser?,
                            frame: CEFFrame?,
                            request: CEFRequest) -> CEFCookieAccessFilter?

    /// Called on the IO thread before a resource request is loaded. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. To redirect or
    /// change the resource load optionally modify |request|. Modification of the
    /// request URL will be treated as a redirect. Return RV_CONTINUE to continue
    /// the request immediately. Return RV_CONTINUE_ASYNC and call
    /// CefRequestCallback:: Continue() at a later time to continue or cancel the
    /// request asynchronously. Return RV_CANCEL to cancel the request immediately.
    /// CEF name: `OnBeforeResourceLoad`
    func onBeforeResourceLoad(browser: CEFBrowser?,
                              frame: CEFFrame?,
                              request: CEFRequest,
                              callback: CEFRequestCallback) -> CEFReturnValue
    
    /// Called on the IO thread before a resource is loaded. The |browser| and
    /// |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. To allow the
    /// resource to load using the default network loader return NULL. To specify a
    /// handler for the resource return a CefResourceHandler object. The |request|
    /// object cannot not be modified in this callback.
    /// CEF name: `GetResourceHandler`
    func resourceHandler(browser: CEFBrowser?,
                         frame: CEFFrame?,
                         request: CEFRequest) -> CEFResourceHandler?

    /// Called on the IO thread when a resource load is redirected. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. The |request|
    /// parameter will contain the old URL and other request-related information.
    /// The |response| parameter will contain the response that resulted in the
    /// redirect. The |new_url| parameter will contain the new URL and can be
    /// changed if desired. The |request| and |response| objects cannot be modified
    /// in this callback.
    /// CEF name: `OnResourceRedirect`
    func onResourceRedirect(browser: CEFBrowser?,
                            frame: CEFFrame?,
                            request: CEFRequest,
                            response: CEFResponse,
                            newURL: inout URL)

    /// Called on the IO thread when a resource response is received. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. To allow the
    /// resource load to proceed without modification return false. To redirect or
    /// retry the resource load optionally modify |request| and return true.
    /// Modification of the request URL will be treated as a redirect. Requests
    /// handled using the default network loader cannot be redirected in this
    /// callback. The |response| object cannot be modified in this callback.
    ///
    /// WARNING: Redirecting using this method is deprecated. Use
    /// OnBeforeResourceLoad or GetResourceHandler to perform redirects.
    /// CEF name: `OnResourceResponse`
    @available(*, deprecated, message: "Use onBeforeResourceLoad or resourceHandler to perform redirects")
    func onResourceResponse(browser: CEFBrowser?,
                            frame: CEFFrame?,
                            request: CEFRequest,
                            response: CEFResponse) -> CEFOnResourceResponseAction

    /// Called on the IO thread to optionally filter resource response content. The
    /// |browser| and |frame| values represent the source of the request, and may
    /// be NULL for requests originating from service workers or CefURLRequest.
    /// |request| and |response| represent the request and response respectively
    /// and cannot be modified in this callback.
    /// CEF name: `GetResourceResponseFilter`
    func resourceResponseFilter(browser: CEFBrowser?,
                                frame: CEFFrame?,
                                request: CEFRequest,
                                response: CEFResponse) -> CEFResponseFilter?

    /// Called on the IO thread when a resource load has completed. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. |request| and
    /// |response| represent the request and response respectively and cannot be
    /// modified in this callback. |status| indicates the load completion status.
    /// |received_content_length| is the number of response bytes actually read.
    /// This method will be called for all requests, including requests that are
    /// aborted due to CEF shutdown or destruction of the associated browser. In
    /// cases where the associated browser is destroyed this callback may arrive
    /// after the CefLifeSpanHandler::OnBeforeClose callback for that browser. The
    /// CefFrame::IsValid method can be used to test for this situation, and care
    /// should be taken not to call |browser| or |frame| methods that modify state
    /// (like LoadURL, SendProcessMessage, etc.) if the frame is invalid.
    /// CEF name: `OnResourceLoadComplete`
    func onResourceLoadComplete(browser: CEFBrowser?,
                                frame: CEFFrame?,
                                request: CEFRequest,
                                response: CEFResponse,
                                status: CEFURLRequestStatus,
                                contentLength: Int64)

    /// Called on the IO thread to handle requests for URLs with an unknown
    /// protocol component. The |browser| and |frame| values represent the source
    /// of the request, and may be NULL for requests originating from service
    /// workers or CefURLRequest. |request| cannot be modified in this callback.
    /// Set |allow_os_execution| to true to attempt execution via the registered OS
    /// protocol handler, if any.
    /// SECURITY WARNING: YOU SHOULD USE THIS METHOD TO ENFORCE RESTRICTIONS BASED
    /// ON SCHEME, HOST OR OTHER URL ANALYSIS BEFORE ALLOWING OS EXECUTION.
    /// CEF name: `OnProtocolExecution`
    func onProtocolExecution(browser: CEFBrowser?,
                             frame: CEFFrame?,
                             request: CEFRequest) -> CEFOnProtocolExecutionAction
    
}

public extension CEFResourceRequestHandler {
    func onGetCookieAccessFilter(browser: CEFBrowser?,
                                 frame: CEFFrame?,
                                 request: CEFRequest) -> CEFCookieAccessFilter? {
        return nil
    }
    
    func onBeforeResourceLoad(browser: CEFBrowser?,
                              frame: CEFFrame?,
                              request: CEFRequest,
                              callback: CEFRequestCallback) -> CEFReturnValue {
        return .continueNow
    }
    
    func resourceHandler(browser: CEFBrowser?,
                         frame: CEFFrame?,
                         request: CEFRequest) -> CEFResourceHandler? {
        return nil
    }
    
    func onResourceRedirect(browser: CEFBrowser?,
                            frame: CEFFrame?,
                            request: CEFRequest,
                            response: CEFResponse,
                            newURL: inout URL) {
    }
    
    func onResourceResponse(browser: CEFBrowser?,
                            frame: CEFFrame?,
                            request: CEFRequest,
                            response: CEFResponse) -> CEFOnResourceResponseAction {
        return .continueLoading
    }

    func resourceResponseFilter(browser: CEFBrowser?,
                                frame: CEFFrame?,
                                request: CEFRequest,
                                response: CEFResponse) -> CEFResponseFilter? {
        return nil
    }

    func onResourceLoadComplete(browser: CEFBrowser?,
                                frame: CEFFrame?,
                                request: CEFRequest,
                                response: CEFResponse,
                                status: CEFURLRequestStatus,
                                contentLength: Int64) {
    }
    
    func onProtocolExecution(browser: CEFBrowser?,
                             frame: CEFFrame?,
                             request: CEFRequest) -> CEFOnProtocolExecutionAction {
        return .cancel
    }

}
