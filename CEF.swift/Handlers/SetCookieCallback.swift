//
//  SetCookieCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface to implement to be notified of asynchronous completion via
/// CefCookieManager::SetCookie().
public protocol SetCookieCallback {
    
    /// Method that will be called upon completion. |success| will be true if the
    /// cookie was set successfully.
    func onComplete(success: Bool)
    
}


public extension SetCookieCallback {
    
    func onComplete(success: Bool) {
    }
    
}
