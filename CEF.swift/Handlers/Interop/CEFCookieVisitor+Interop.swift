//
//  CEFCookieVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFCookieVisitor_visit(ptr: UnsafeMutablePointer<cef_cookie_visitor_t>?,
                            cookie: UnsafePointer<cef_cookie_t>?,
                            index: Int32,
                            count: Int32,
                            deletePtr: UnsafeMutablePointer<Int32>?) -> Int32 {
    guard let obj = CEFCookieVisitorMarshaller.get(ptr) else {
        return 0
    }
    
    var shouldDelete: Bool = false
    let result = obj.visit(cookie: CEFCookie.fromCEF(cookie!.pointee),
                           index: Int(index),
                           count: Int(count),
                           shouldDelete: &shouldDelete)
    
    deletePtr!.pointee = shouldDelete ? 1 : 0
    return result ? 1 : 0
}

