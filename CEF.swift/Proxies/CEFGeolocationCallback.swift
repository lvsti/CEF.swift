//
//  CEFGeolocationCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFGeolocationCallback {
    
    /// Call to allow or deny geolocation access.
    /// CEF name: `Continue`
    public func doContinue(allowAccess: Bool) {
        cefObject.cont(cefObjectPtr, allowAccess ? 1 : 0)
    }
    
}

