//
//  CEFDOMVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_domvisitor_t: CEFObject {
}

typealias CEFDOMVisitorMarshaller = CEFMarshaller<CEFDOMVisitor, cef_domvisitor_t>

extension CEFDOMVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_domvisitor_t> {
        return CEFDOMVisitorMarshaller.pass(self)
    }
}

extension cef_domvisitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFDOMVisitor_visit
    }
}

func CEFDOMVisitor_visit(ptr: UnsafeMutablePointer<cef_domvisitor_t>,
                         document: UnsafeMutablePointer<cef_domdocument_t>) {
    guard let obj = CEFDOMVisitorMarshaller.get(ptr) else {
        return
    }
    
    obj.visit(CEFDOMDocument.fromCEF(document)!)
}

