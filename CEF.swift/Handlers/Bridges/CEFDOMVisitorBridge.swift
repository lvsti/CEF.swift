//
//  CEFDOMVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFDOMVisitorVisitBlock = (document: CEFDOMDocument) -> Void

class CEFDOMVisitorBridge: CEFDOMVisitor {
    let block: CEFDOMVisitorVisitBlock
    
    init(block: CEFDOMVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(document: CEFDOMDocument) {
        block(document: document)
    }
}
