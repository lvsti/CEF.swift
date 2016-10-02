//
//  CEFStringVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed.
public typealias CEFStringVisitorVisitBlock = (_ string: String) -> Void

class CEFStringVisitorBridge: CEFStringVisitor {
    let block: CEFStringVisitorVisitBlock
    
    init(block: @escaping CEFStringVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(string: String) {
        block(string)
    }
}
