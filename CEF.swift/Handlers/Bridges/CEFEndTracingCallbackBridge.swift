//
//  CEFEndTracingCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Called after all processes have sent their trace data. |tracing_file| is
/// the path at which tracing data was written. The client is responsible for
/// deleting |tracing_file|.
public typealias CEFEndTracingCallbackOnEndTracingCompleteBlock = (traceFilePath: String) -> Void

class CEFEndTracingCallbackBridge: CEFEndTracingCallback {
    let block: CEFEndTracingCallbackOnEndTracingCompleteBlock
    
    init(block: CEFEndTracingCallbackOnEndTracingCompleteBlock) {
        self.block = block
    }
    
    func onEndTracingComplete(traceFilePath: String) {
        block(traceFilePath: traceFilePath)
    }
}

