//
//  CEFResourceSkipCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 25..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFResourceSkipCallback {
    
    /// Callback for asynchronous continuation of Skip(). If |bytes_skipped| > 0
    /// then either Skip() will be called again until the requested number of
    /// bytes have been skipped or the request will proceed. If |bytes_skipped|
    /// <= 0 the request will fail with ERR_REQUEST_RANGE_NOT_SATISFIABLE.
    /// CEF name: `Continue`
    func doContinue(bytesSkipped: Int64) {
        cefObject.cont(cefObjectPtr, bytesSkipped)
    }
    
}
