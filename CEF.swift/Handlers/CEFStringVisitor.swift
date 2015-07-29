//
//  CEFStringVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_string_visitor_t: CEFObject {
}

typealias CEFStringVisitorMarshaller = CEFMarshaller<CEFStringVisitor>

public class CEFStringVisitor: CEFHandler, CEFMarshallable {
    typealias StructType = cef_string_visitor_t
    
    public func visit(string: String) {
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_string_visitor_t> {
        return CEFStringVisitorMarshaller.pass(self)
    }
    
    func marshalCallbacks(inout cefStruct: cef_string_visitor_t) {
        cefStruct.visit = CEFStringVisitor_visit
    }
}

func CEFStringVisitor_visit(ptr: UnsafeMutablePointer<cef_string_visitor_t>,
                            string: UnsafePointer<cef_string_t>) {
    guard let obj = CEFStringVisitorMarshaller.get(ptr) else {
        return
    }
    
    obj.visit(CEFStringToSwiftString(string.memory))
}

