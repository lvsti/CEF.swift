//
//  CEFGeolocationUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFGeolocationUtils {
    
    /// Request a one-time geolocation update. This function bypasses any user
    /// permission checks so should only be used by code that is allowed to access
    /// location information.
    /// CEF name: `CefGetGeolocation`
    @discardableResult
    public static func getGeolocation(callback: CEFGetGeolocationCallback) -> Bool {
        return cef_get_geolocation(callback.toCEF()) != 0
    }

    /// Request a one-time geolocation update. This function bypasses any user
    /// permission checks so should only be used by code that is allowed to access
    /// location information.
    /// CEF name: `CefGetGeolocation`
    @discardableResult
    public static func getGeolocation(block: @escaping CEFGetGeolocationCallbackOnLocationUpdateBlock) -> Bool {
        return getGeolocation(callback: CEFGetGeolocationCallbackBridge(block: block))
    }

}
