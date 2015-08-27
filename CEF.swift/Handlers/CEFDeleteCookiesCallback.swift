//
//  CEFDeleteCookiesCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface to implement to be notified of asynchronous completion via
// CefCookieManager::DeleteCookies().
///
public protocol CEFDeleteCookiesCallback {
    
    ///
    // Method that will be called upon completion. |num_deleted| will be the
    // number of cookies that were deleted or -1 if unknown.
    ///
    func onComplete(deletedCount: Int?)
    
}


public extension CEFDeleteCookiesCallback {
    
    func onComplete(deletedCount: Int?) {
    }
    
}
