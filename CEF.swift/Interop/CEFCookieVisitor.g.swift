//
//  CEFCookieVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_cookie_visitor_t: CEFObject {
}

typealias CEFCookieVisitorMarshaller = CEFMarshaller<CEFCookieVisitor, cef_cookie_visitor_t>

extension CEFCookieVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_cookie_visitor_t> {
        return CEFCookieVisitorMarshaller.pass(self)
    }
}

extension cef_cookie_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFCookieVisitor_visit
    }
}

func CEFCookieVisitor_visit(ptr: UnsafeMutablePointer<cef_cookie_visitor_t>,
                            cookie: UnsafePointer<cef_cookie_t>,
                            index: Int32,
                            count: Int32,
                            deletePtr: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFCookieVisitorMarshaller.get(ptr) else {
        return 0
    }
    
    var shouldDelete: Bool = false
    let result = obj.visit(CEFCookie.fromCEF(cookie.memory),
                           index: Int(index),
                           count: Int(count),
                           shouldDelete: &shouldDelete)
    
    deletePtr.memory = shouldDelete ? 1 : 0
    return result ? 1 : 0
}

