//
//  CEFSchemeHandlerFactory.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class that creates CefResourceHandler instances for handling scheme requests.
/// The methods of this class will always be called on the IO thread.
/// CEF name: `CefSchemeHandlerFactory`
public protocol CEFSchemeHandlerFactory {
    
    /// Return a new resource handler instance to handle the request or an empty
    /// reference to allow default handling of the request. |browser| and |frame|
    /// will be the browser window and frame respectively that originated the
    /// request or NULL if the request did not originate from a browser window
    /// (for example, if the request came from CefURLRequest). The |request| object
    /// passed to this method cannot be modified.
    /// CEF name: `Create`
    func create(browser: CEFBrowser?, frame: CEFFrame?, scheme: String, request: CEFRequest) -> CEFResourceHandler?
    
}

public extension CEFSchemeHandlerFactory {
    
    func create(browser: CEFBrowser?, frame: CEFFrame?, scheme: String, request: CEFRequest) -> CEFResourceHandler? {
        return nil
    }
    
}
