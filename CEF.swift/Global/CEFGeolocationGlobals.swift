//
//  CEFGeolocationGlobals.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Request a one-time geolocation update. This function bypasses any user
// permission checks so should only be used by code that is allowed to access
// location information.
///
public func CEFGetGeolocation(callback: CEFGetGeolocationCallback) -> Bool {
    return cef_get_geolocation(callback.toCEF()) != 0
}

public func CEFGetGeolocation(block: CEFGetGeolocationCallbackOnLocationUpdateBlock) -> Bool {
    return CEFGetGeolocation(CEFGetGeolocationCallbackBridge(block: block))
}
