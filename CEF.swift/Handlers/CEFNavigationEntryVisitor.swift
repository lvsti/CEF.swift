//
//  CEFNavigationEntryVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFNavigationEntryVisitor: CEFHandler {
    
    public override init() {
        super.init()
    }

    public func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> Bool {
        return false
    }
    
}

