//
//  CEFEndTracingCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

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

