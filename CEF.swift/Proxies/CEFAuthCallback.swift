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
    /// CEF name: `Continue`
    public func doContinue(username: String?, password: String?) {
        let cefUserPtr = username != nil ? CEFStringPtrCreateFromSwiftString(username!) : nil
        let cefPassPtr = password != nil ? CEFStringPtrCreateFromSwiftString(password!) : nil
        defer {
            CEFStringPtrRelease(cefUserPtr)
            CEFStringPtrRelease(cefPassPtr)
        }
        cefObject.cont(cefObjectPtr, cefUserPtr, cefPassPtr)
    }
    
    /// Cancel the authentication request.
    /// CEF name: `Cancel`
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
}
