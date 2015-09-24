//
//  WebPluginInfoVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface to implement for visiting web plugin information. The methods of
/// this class will be called on the browser process UI thread.
public protocol WebPluginInfoVisitor {
    
    /// Method that will be called once for each plugin. |count| is the 0-based
    /// index for the current plugin. |total| is the total number of plugins.
    /// Return false to stop visiting plugins. This method may never be called if
    /// no plugins are found.
    func visit(pluginInfo: WebPluginInfo, index: Int, totalCount: Int) -> Bool
    
}

public extension WebPluginInfoVisitor {

    func visit(pluginInfo: WebPluginInfo, index: Int, totalCount: Int) -> Bool {
        return false
    }
    
}

