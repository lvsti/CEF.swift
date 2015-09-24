//
//  TaskBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed on the target thread.
public typealias TaskExecuteBlock = () -> Void

class TaskBridge: Task {
    let block: TaskExecuteBlock
    
    init(block: TaskExecuteBlock) {
        self.block = block
    }
    
    func execute() {
        block()
    }
}
