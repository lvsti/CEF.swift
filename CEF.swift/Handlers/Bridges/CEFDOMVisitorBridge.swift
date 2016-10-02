//
//  CEFDOMVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method executed for visiting the DOM. The document object passed to this
/// method represents a snapshot of the DOM at the time this method is
/// executed. DOM objects are only valid for the scope of this method. Do not
/// keep references to or attempt to access any DOM objects outside the scope
/// of this method.
public typealias CEFDOMVisitorVisitBlock = (_ document: CEFDOMDocument) -> Void

class CEFDOMVisitorBridge: CEFDOMVisitor {
    let block: CEFDOMVisitorVisitBlock
    
    init(block: @escaping CEFDOMVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(document: CEFDOMDocument) {
        block(document)
    }
}
