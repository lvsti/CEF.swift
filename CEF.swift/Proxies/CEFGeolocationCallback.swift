//
//  CEFGeolocationCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_geolocation_callback_t: CEFObject {
}

/// Callback interface used for asynchronous continuation of geolocation
/// permission requests.
public class CEFGeolocationCallback: CEFProxy<cef_geolocation_callback_t> {
    
    /// Call to allow or deny geolocation access.
    public func doContinue(allow: Bool) {
        cefObject.cont(cefObjectPtr, allow ? 1 : 0)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFGeolocationCallback? {
        return CEFGeolocationCallback(ptr: ptr)
    }
    
}

