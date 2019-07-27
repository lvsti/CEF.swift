//
//  CEFCookieAccessFilter.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 27..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to filter cookies that may be sent or received from
/// resource requests. The methods of this class will be called on the IO thread
/// unless otherwise indicated.
/// CEF name: `CefCookieAccessFilter`
public protocol CEFCookieAccessFilter {
    /// Called on the IO thread before a resource request is sent. The |browser|
    /// and |frame| values represent the source of the request, and may be NULL for
    /// requests originating from service workers or CefURLRequest. |request|
    /// cannot be modified in this callback. Return true if the specified cookie
    /// can be sent with the request or false otherwise.
    /// CEF name: `CanSendCookie`
    func canSendCookie(browser: CEFBrowser?,
                       frame: CEFFrame?,
                       request: CEFRequest,
                       cookie: CEFCookie) -> Bool
    
    /// Called on the IO thread after a resource response is received. The
    /// |browser| and |frame| values represent the source of the request, and may
    /// be NULL for requests originating from service workers or CefURLRequest.
    /// |request| cannot be modified in this callback. Return true if the specified
    /// cookie returned with the response can be saved or false otherwise.
    /// CEF name: `CanSaveCookie`
    func canSaveCookie(browser: CEFBrowser?,
                       frame: CEFFrame?,
                       request: CEFRequest,
                       response: CEFResponse,
                       cookie: CEFCookie) -> Bool
}

public extension CEFCookieAccessFilter {
    func canSendCookie(browser: CEFBrowser?,
                       frame: CEFFrame?,
                       request: CEFRequest,
                       cookie: CEFCookie) -> Bool {
        return true
    }
    
    func canSaveCookie(browser: CEFBrowser?,
                       frame: CEFFrame?,
                       request: CEFRequest,
                       response: CEFResponse,
                       cookie: CEFCookie) -> Bool {
        return true
    }
}
