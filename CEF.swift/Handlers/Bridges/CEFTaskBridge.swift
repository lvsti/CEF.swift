//
//  CEFTaskBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed on the target thread.
public typealias CEFTaskExecuteBlock = () -> Void

class CEFTaskBridge: CEFTask {
    let block: CEFTaskExecuteBlock
    
    init(block: CEFTaskExecuteBlock) {
        self.block = block
    }
    
    func execute() {
        block()
    }
}
