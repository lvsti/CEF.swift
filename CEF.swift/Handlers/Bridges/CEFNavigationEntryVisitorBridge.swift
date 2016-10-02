//
//  CEFNavigationEntryVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed. Do not keep a reference to |entry| outside of
/// this callback. Return true to continue visiting entries or false to stop.
/// |current| is true if this entry is the currently loaded navigation entry.
/// |index| is the 0-based index of this entry and |total| is the total number
/// of entries.
public typealias CEFNavigationEntryVisitorVisitBlock =
    (_ entry: CEFNavigationEntry, _ isCurrent: Bool, _ index: Int, _ totalCount: Int) -> Bool

class CEFNavigationEntryVisitorBridge: CEFNavigationEntryVisitor {
    let block: CEFNavigationEntryVisitorVisitBlock
    
    init(block: @escaping CEFNavigationEntryVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> Bool {
        return block(entry, isCurrent, index, totalCount)
    }
}
