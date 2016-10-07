//
//  CEFPrintJobCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFPrintJobCallback {

    /// Indicate completion of the print job.
    /// CEF name: `Continue`
    public func doContinue() {
        cefObject.cont(cefObjectPtr)
    }
    
}

