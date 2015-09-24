//
//  CompletionCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called once the task is complete.
public typealias CompletionCallbackOnCompleteBlock = () -> Void

class CompletionCallbackBridge: CompletionCallback {
    let block: CompletionCallbackOnCompleteBlock
    
    init(block: CompletionCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete() {
        block()
    }
}

