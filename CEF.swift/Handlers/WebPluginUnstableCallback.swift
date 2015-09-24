//
//  WebPluginUnstableCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface to implement for receiving unstable plugin information. The methods
/// of this class will be called on the browser process IO thread.
public protocol WebPluginUnstableCallback {
    
    /// Method that will be called for the requested plugin. |unstable| will be
    /// true if the plugin has reached the crash count threshold of 3 times in 120
    /// seconds.
    func isUnstable(path: String, unstable: Bool)
    
}

public extension WebPluginUnstableCallback {
    
    func isUnstable(path: String, unstable: Bool) {
    }
    
}

