//
//  CEFCookieVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFCookieVisitorAction {
    case continueVisiting
    case stop
}

/// Interface to implement for visiting cookie values. The methods of this class
/// will always be called on the UI thread.
/// CEF name: `CefCookieVisitor`
public protocol CEFCookieVisitor {
    
    /// Method that will be called once for each cookie. |count| is the 0-based
    /// index for the current cookie. |total| is the total number of cookies.
    /// Set |deleteCookie| to true to delete the cookie currently being visited.
    /// Return false to stop visiting cookies. This method may never be called if
    /// no cookies are found.
    /// CEF name: `Visit`
    func visit(cookie: CEFCookie, index: Int, count: Int, shouldDelete: inout Bool) -> CEFCookieVisitorAction
    
}


public extension CEFCookieVisitor {
    
    func visit(cookie: CEFCookie, index: Int, count: Int, shouldDelete: inout Bool) -> CEFCookieVisitorAction {
        return .stop
    }
    
}
