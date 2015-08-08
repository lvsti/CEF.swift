//
//  CEFGeolocationHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFGeolocationRequestID = Int32

///
// Implement this interface to handle events related to geolocation permission
// requests. The methods of this class will be called on the browser process UI
// thread.
///
public protocol CEFGeolocationHandler {
    
    ///
    // Called when a page requests permission to access geolocation information.
    // |requesting_url| is the URL requesting permission and |request_id| is the
    // unique ID for the permission request. Return true and call
    // CefGeolocationCallback::Continue() either in this method or at a later
    // time to continue or cancel the request. Return false to cancel the request
    // immediately.
    ///
    func onRequestGeolocationPermission(browser: CEFBrowser,
                                        url: NSURL,
                                        requestID: CEFGeolocationRequestID,
                                        callback: CEFGeolocationCallback) -> Bool
    
    ///
    // Called when a geolocation access request is canceled. |requesting_url| is
    // the URL that originally requested permission and |request_id| is the unique
    // ID for the permission request.
    ///
    func onCancelGeolocationPermission(browser: CEFBrowser,
                                       url: NSURL,
                                       requestID: CEFGeolocationRequestID)

}

public extension CEFGeolocationHandler {

    func onRequestGeolocationPermission(browser: CEFBrowser,
                                        url: NSURL,
                                        requestID: CEFGeolocationRequestID,
                                        callback: CEFGeolocationCallback) -> Bool {
        return false
    }

    func onCancelGeolocationPermission(browser: CEFBrowser,
                                       url: NSURL,
                                       requestID: CEFGeolocationRequestID) {
    }
    
}

