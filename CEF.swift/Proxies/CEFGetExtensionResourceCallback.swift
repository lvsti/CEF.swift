//
//  CEFGetExtensionResourceCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 02..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFGetExtensionResourceCallback {
    
    /// Continue the request. Read the resource contents from |stream|.
    /// CEF name: `Continue`
    public func doContinue(stream: CEFStreamReader?) {
        cefObject.cont(cefObjectPtr, stream?.toCEF())
    }
    
    /// Cancel the request.
    /// CEF name: `Cancel`
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
}
