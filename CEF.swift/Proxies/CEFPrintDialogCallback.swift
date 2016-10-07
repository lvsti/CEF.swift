//
//  CEFPrintDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFPrintDialogCallback {

    /// Continue printing with the specified |settings|.
    /// CEF name: `Continue`
    public func doContinue(settings: CEFPrintSettings) {
        cefObject.cont(cefObjectPtr, settings.toCEF())
    }
    
    /// Cancel the printing.
    /// CEF name: `Cancel`
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

}

