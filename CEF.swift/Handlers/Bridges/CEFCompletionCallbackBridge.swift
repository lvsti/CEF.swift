//
//  CEFCompletionCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFCompletionCallbackOnCompleteBlock = () -> Void

class CEFCompletionCallbackBridge: CEFCompletionCallback {
    let block: CEFCompletionCallbackOnCompleteBlock
    
    init(block: CEFCompletionCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete() {
        block()
    }
}

