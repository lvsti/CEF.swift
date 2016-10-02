//
//  CEFCookieVisitorBridge.swift
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
public typealias CEFCookieVisitorVisitBlock =
    (_ cookie: CEFCookie, _ index: Int, _ count: Int, _ shouldDelete: inout Bool) -> Bool

class CEFCookieVisitorBridge: CEFCookieVisitor {
    let block: CEFCookieVisitorVisitBlock
    
    init(block: @escaping CEFCookieVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(cookie: CEFCookie, index: Int, count: Int, shouldDelete: inout Bool) -> Bool {
        return block(cookie, index, count, &shouldDelete)
    }
}
