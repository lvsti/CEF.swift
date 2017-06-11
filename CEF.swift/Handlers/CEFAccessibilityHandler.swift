//
//  CEFAccessibilityHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 06. 11..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive accessibility notification when
/// accessibility events have been registered. The methods of this class will
/// be called on the UI thread.
/// CEF name: `CefAccessibilityHandler`
public protocol CEFAccessibilityHandler {
    
    /// Called after renderer process sends accessibility tree changes to the
    /// browser process.
    /// CEF name: `OnAccessibilityTreeChange`
    func onAccessibilityTreeChange(value: CEFValue)
    
    /// Called after renderer process sends accessibility location changes to the
    /// browser process.
    /// CEF name: `OnAccessibilityLocationChange`
    func onAccessibilityLocationChange(value: CEFValue)

}

public extension CEFAccessibilityHandler {

    func onAccessibilityTreeChange(value: CEFValue) {
    }

    func onAccessibilityLocationChange(value: CEFValue) {
    }

}
