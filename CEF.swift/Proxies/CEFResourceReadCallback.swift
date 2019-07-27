//
//  CEFResourceReadCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 25..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFResourceReadCallback {
    
    /// Callback for asynchronous continuation of Read(). If |bytes_read| == 0
    /// the response will be considered complete. If |bytes_read| > 0 then Read()
    /// will be called again until the request is complete (based on either the
    /// result or the expected content length). If |bytes_read| < 0 then the
    /// request will fail and the |bytes_read| value will be treated as the error
    /// code.
    /// CEF name: `Continue`
    func doContinue(bytesRead: Int) {
        cefObject.cont(cefObjectPtr, Int32(bytesRead))
    }

}
