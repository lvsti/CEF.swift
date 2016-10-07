//
//  CEFRequestCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFRequestCallback {
    
    /// Continue the url request. If |allow| is true the request will be continued.
    /// Otherwise, the request will be canceled.
    /// CEF name: `Continue`
    func doContinue(allow: Bool) {
        cefObject.cont(cefObjectPtr, allow ? 1 : 0)
    }
    
    /// Cancel the url request.
    /// CEF name: `Cancel`
    func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

}

