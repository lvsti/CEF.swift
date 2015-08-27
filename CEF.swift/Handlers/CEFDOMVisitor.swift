//
//  CEFDOMVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface to implement for visiting the DOM. The methods of this class will
// be called on the render process main thread.
///
public protocol CEFDOMVisitor {

    ///
    // Method executed for visiting the DOM. The document object passed to this
    // method represents a snapshot of the DOM at the time this method is
    // executed. DOM objects are only valid for the scope of this method. Do not
    // keep references to or attempt to access any DOM objects outside the scope
    // of this method.
    ///
    func visit(document: CEFDOMDocument)
    
}

public extension CEFDOMVisitor {
    
    func visit(document: CEFDOMDocument) {
    }
    
}
