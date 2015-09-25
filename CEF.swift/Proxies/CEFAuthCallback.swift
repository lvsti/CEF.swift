//
//  CEFAuthCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFAuthCallback {
    
    /// Continue the authentication request.
    public func doContinue(username: String, password: String) {
        let cefUserPtr = CEFStringPtrCreateFromSwiftString(username)
        let cefPassPtr = CEFStringPtrCreateFromSwiftString(password)
        defer {
            CEFStringPtrRelease(cefUserPtr)
            CEFStringPtrRelease(cefPassPtr)
        }
        cefObject.cont(cefObjectPtr, cefUserPtr, cefPassPtr)
    }
    
    /// Cancel the authentication request.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
}
