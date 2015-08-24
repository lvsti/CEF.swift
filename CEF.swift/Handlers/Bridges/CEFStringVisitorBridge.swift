//
//  CEFStringVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFStringVisitorVisitBlock = (string: String) -> ()

class CEFStringVisitorBridge: CEFStringVisitor {
    let block: CEFStringVisitorVisitBlock
    
    init(block: CEFStringVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(string: String) {
        block(string: string)
    }
}
