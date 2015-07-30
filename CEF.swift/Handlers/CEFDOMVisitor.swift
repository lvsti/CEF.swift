//
//  CEFDOMVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_domvisitor_t: CEFObject {
}

typealias CEFDOMVisitorMarshaller = CEFMarshaller<CEFDOMVisitor>

public class CEFDOMVisitor: CEFHandler, CEFMarshallable {
    typealias StructType = cef_domvisitor_t

    public override init() {
        super.init()
    }

    public func visit(document: CEFDOMDocument) {
    }

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

