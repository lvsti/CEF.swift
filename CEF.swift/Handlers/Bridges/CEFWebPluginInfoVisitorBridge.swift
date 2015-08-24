//
//  CEFWebPluginInfoVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFWebPluginInfoVisitorVisitBlock = (pluginInfo: CEFWebPluginInfo, index: Int, totalCount: Int) -> Bool

class CEFWebPluginInfoVisitorBridge: CEFWebPluginInfoVisitor {
    let block: CEFWebPluginInfoVisitorVisitBlock
    
    init(block: CEFWebPluginInfoVisitorVisitBlock) {
        self.block = block
    }
    
    func visit(pluginInfo: CEFWebPluginInfo, index: Int, totalCount: Int) -> Bool {
        return block(pluginInfo: pluginInfo, index: index, totalCount: totalCount)
    }
}
