//
//  CEFCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 04..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFCallback {

    /// Continue processing.
    public func doContinue() {
        cefObject.cont(cefObjectPtr)
    }
    
    /// Cancel processing.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

}

