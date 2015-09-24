//
//  RequestContextHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations. The handler
/// instance will not be released until all objects related to the context have
/// been destroyed.
public protocol RequestContextHandler {
    
    /// Called on the IO thread to retrieve the cookie manager. If this method
    /// returns NULL the default cookie manager retrievable via
    /// CefRequestContext::GetDefaultCookieManager() will be used.
    var cookieManager: CookieManager? { get }
    
}


public extension RequestContextHandler {
    
    var cookieManager: CookieManager? { return nil }
    
}

