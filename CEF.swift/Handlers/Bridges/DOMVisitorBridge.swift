//
//  DOMVisitorBridge.swift
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
public typealias DOMVisitorVisitBlock = (document: DOMDocument) -> Void

class DOMVisitorBridge: DOMVisitor {
    let block: DOMVisitorVisitBlock
    
    init(block: DOMVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(document: DOMDocument) {
        block(document: document)
    }
}
