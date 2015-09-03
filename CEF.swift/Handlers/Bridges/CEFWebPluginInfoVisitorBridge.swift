//
//  CEFWebPluginInfoVisitorBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called once for each plugin. |count| is the 0-based
/// index for the current plugin. |total| is the total number of plugins.
/// Return false to stop visiting plugins. This method may never be called if
/// no plugins are found.
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
