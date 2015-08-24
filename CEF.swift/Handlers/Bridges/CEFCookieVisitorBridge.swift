//
//  CEFCookieVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFCookieVisitorVisitBlock = (cookie: CEFCookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool

class CEFCookieVisitorBridge: CEFCookieVisitor {
    let block: CEFCookieVisitorVisitBlock
    
    init(block: CEFCookieVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(cookie: CEFCookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool {
        return block(cookie: cookie, index: index, count: count, shouldDelete: &shouldDelete)
    }
}
