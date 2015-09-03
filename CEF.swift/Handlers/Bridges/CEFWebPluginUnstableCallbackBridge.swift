//
//  CEFWebPluginUnstableCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFWebPluginUnstableCallbackIsUnstableBlock = (path: String, unstable: Bool) -> Void

class CEFWebPluginUnstableCallbackBridge: CEFWebPluginUnstableCallback {
    let block: CEFWebPluginUnstableCallbackIsUnstableBlock
    
    init(block: CEFWebPluginUnstableCallbackIsUnstableBlock) {
        self.block = block
    }
    
    func isUnstable(path: String, unstable: Bool) {
        block(path: path, unstable: unstable)
    }
}
