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

typealias CEFDOMVisitorMarshaller = CEFMarshaller<CEFDOMVisitor>

extension CEFDOMVisitor: CEFMarshallable {
    typealias StructType = cef_domvisitor_t
    
    func toCEF() -> UnsafeMutablePointer<cef_domvisitor_t> {
        return CEFDOMVisitorMarshaller.pass(self)
    }
    
    func marshalCallbacks(inout cefStruct: cef_domvisitor_t) {
        cefStruct.visit = CEFDOMVisitor_visit
    }

}

func CEFDOMVisitor_visit(ptr: UnsafeMutablePointer<cef_domvisitor_t>,
                         document: UnsafeMutablePointer<cef_domdocument_t>) {
    guard let obj = CEFDOMVisitorMarshaller.get(ptr) else {
        return
    }
    
    obj.visit(CEFDOMDocument.fromCEF(document)!)
}

