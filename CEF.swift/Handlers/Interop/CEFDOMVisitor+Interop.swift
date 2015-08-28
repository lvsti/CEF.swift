//
//  CEFDOMVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDOMVisitor_visit(ptr: UnsafeMutablePointer<cef_domvisitor_t>,
                         document: UnsafeMutablePointer<cef_domdocument_t>) {
    guard let obj = CEFDOMVisitorMarshaller.get(ptr) else {
        return
    }
    
    obj.visit(CEFDOMDocument.fromCEF(document)!)
}

