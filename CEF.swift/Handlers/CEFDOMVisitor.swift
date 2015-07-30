//
//  CEFDOMVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFDOMVisitor {

    func visit(document: CEFDOMDocument)
    
}

public extension CEFDOMVisitor {
    
    func visit(document: CEFDOMDocument) {
    }
    
}
