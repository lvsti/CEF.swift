//
//  CEFAuthCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_auth_callback_t: CEFObject {
}

/// Callback interface used for asynchronous continuation of authentication
/// requests.
public class CEFAuthCallback: CEFProxy<cef_auth_callback_t> {
    
    /// Continue the authentication request.
    func doContinue(username: String, password: String) {
        let cefUserPtr = CEFStringPtrCreateFromSwiftString(username)
        let cefPassPtr = CEFStringPtrCreateFromSwiftString(password)
        defer {
            CEFStringPtrRelease(cefUserPtr)
            CEFStringPtrRelease(cefPassPtr)
        }
        cefObject.cont(cefObjectPtr, cefUserPtr, cefPassPtr)
    }
    
    /// Cancel the authentication request.
    func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFAuthCallback? {
        return CEFAuthCallback(ptr: ptr)
    }
    
}
