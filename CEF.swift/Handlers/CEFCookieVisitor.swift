//
//  CEFCookieVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFCookieVisitor {
    
    func visit(cookie: CEFCookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool
    
}


public extension CEFCookieVisitor {
    
    func visit(cookie: CEFCookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool {
        return false
    }
    
}
