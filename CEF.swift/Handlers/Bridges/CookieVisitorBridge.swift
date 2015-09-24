//
//  CookieVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called once for each cookie. |count| is the 0-based
/// index for the current cookie. |total| is the total number of cookies.
/// Set |deleteCookie| to true to delete the cookie currently being visited.
/// Return false to stop visiting cookies. This method may never be called if
/// no cookies are found.
public typealias CookieVisitorVisitBlock = (cookie: Cookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool

class CookieVisitorBridge: CookieVisitor {
    let block: CookieVisitorVisitBlock
    
    init(block: CookieVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(cookie: Cookie, index: Int, count: Int, inout shouldDelete: Bool) -> Bool {
        return block(cookie: cookie, index: index, count: count, shouldDelete: &shouldDelete)
    }
}
