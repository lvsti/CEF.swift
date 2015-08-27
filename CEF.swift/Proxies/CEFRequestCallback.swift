//
//  CEFRequestCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_request_callback_t: CEFObject {
}

/// Callback interface used for asynchronous continuation of url requests.
public class CEFRequestCallback: CEFProxy<cef_request_callback_t> {
    
    /// Continue the url request. If |allow| is true the request will be continued.
    /// Otherwise, the request will be canceled.
    func doContinue(allow: Bool) {
        cefObject.cont(cefObjectPtr, allow ? 1 : 0)
    }
    
    /// Cancel the url request.
    func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFRequestCallback? {
        return CEFRequestCallback(ptr: ptr)
    }

}

