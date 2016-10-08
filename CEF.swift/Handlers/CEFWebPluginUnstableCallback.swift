//
//  CEFWebPluginUnstableCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface to implement for receiving unstable plugin information. The methods
/// of this class will be called on the browser process IO thread.
/// CEF name: `CefWebPluginUnstableCallback`
public protocol CEFWebPluginUnstableCallback {
    
    /// Method that will be called for the requested plugin. |unstable| will be
    /// true if the plugin has reached the crash count threshold of 3 times in 120
    /// seconds.
    /// CEF name: `IsUnstable`
    func onPluginStabilityReport(path: String, isUnstable: Bool)
    
}

public extension CEFWebPluginUnstableCallback {
    
    func onPluginStabilityReport(path: String, isUnstable: Bool) {
    }
    
}

