//
//  CEFNavigationEntryVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFNavigationEntryVisitorVisitBlock =
    (entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> Bool

class CEFNavigationEntryVisitorBridge: CEFNavigationEntryVisitor {
    let block: CEFNavigationEntryVisitorVisitBlock
    
    init(block: CEFNavigationEntryVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> Bool {
        return block(entry: entry, isCurrent: isCurrent, index: index, totalCount: totalCount)
    }
}
