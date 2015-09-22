//
//  PrintDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_print_dialog_callback_t: CEFObject {
}

/// Callback interface for asynchronous continuation of print dialog requests.
public class PrintDialogCallback: Proxy<cef_print_dialog_callback_t> {

    /// Continue printing with the specified |settings|.
    public func doContinue(settings: PrintSettings) {
        cefObject.cont(cefObjectPtr, settings.toCEF())
    }
    
    /// Cancel the printing.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> PrintDialogCallback? {
        return PrintDialogCallback(ptr: ptr)
    }

}

