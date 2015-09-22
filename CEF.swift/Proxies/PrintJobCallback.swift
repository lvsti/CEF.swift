//
//  PrintJobCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_print_job_callback_t: CEFObject {
}

/// Callback interface for asynchronous continuation of print job requests.
public class PrintJobCallback: Proxy<cef_print_job_callback_t> {

    /// Indicate completion of the print job.
    public func doContinue() {
        cefObject.cont(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> PrintJobCallback? {
        return PrintJobCallback(ptr: ptr)
    }

}

