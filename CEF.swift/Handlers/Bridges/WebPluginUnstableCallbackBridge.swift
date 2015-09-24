//
//  WebPluginUnstableCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called for the requested plugin. |unstable| will be
/// true if the plugin has reached the crash count threshold of 3 times in 120
/// seconds.
public typealias WebPluginUnstableCallbackIsUnstableBlock = (path: String, unstable: Bool) -> Void

class WebPluginUnstableCallbackBridge: WebPluginUnstableCallback {
    let block: WebPluginUnstableCallbackIsUnstableBlock
    
    init(block: WebPluginUnstableCallbackIsUnstableBlock) {
        self.block = block
    }
    
    func isUnstable(path: String, unstable: Bool) {
        block(path: path, unstable: unstable)
    }
}
