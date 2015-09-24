//
//  StringVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed.
public typealias StringVisitorVisitBlock = (string: String) -> Void

class StringVisitorBridge: StringVisitor {
    let block: StringVisitorVisitBlock
    
    init(block: StringVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(string: String) {
        block(string: string)
    }
}
