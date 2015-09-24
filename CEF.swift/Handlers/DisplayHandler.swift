//
//  DisplayHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum OnConsoleMessageAction {
    case Allow
    case Cancel
}

extension OnConsoleMessageAction: BooleanType {
    public var boolValue: Bool { return self == .Cancel }
}

public enum OnTooltipAction {
    case ShowDefault
    case ShowCustom
}

extension OnTooltipAction: BooleanType {
    public var boolValue: Bool { return self == .ShowCustom }
}

/// Implement this interface to handle events related to browser display state.
/// The methods of this class will be called on the UI thread.
public protocol DisplayHandler {
    /// Called when a frame's address has changed.
    func onAddressChange(browser: Browser, frame: Frame, url: NSURL)
    
    /// Called when the page title changes.
    func onTitleChange(browser: Browser, title: String?)
    
    /// Called when the page icon changes.
    func onFaviconURLChange(browser: Browser, iconURLs: [NSURL]?)
    
    /// Called when the browser is about to display a tooltip. |text| contains the
    /// text that will be displayed in the tooltip. To handle the display of the
    /// tooltip yourself return true. Otherwise, you can optionally modify |text|
    /// and then return false to allow the browser to display the tooltip.
    /// When window rendering is disabled the application is responsible for
    /// drawing tooltips and the return value is ignored.
    func onTooltip(browser: Browser, inout text: String?) -> OnTooltipAction
    
    /// Called when the browser receives a status message. |value| contains the
    /// text that will be displayed in the status message.
    func onStatusMessage(browser: Browser, text: String?)
    
    /// Called to display a console message. Return true to stop the message from
    /// being output to the console.
    func onConsoleMessage(browser: Browser,
                          message: String?,
                          source: String?,
                          lineNumber: Int) -> OnConsoleMessageAction

}

public extension DisplayHandler {

    func onAddressChange(browser: Browser, frame: Frame, url: NSURL) {
    }
    
    func onTitleChange(browser: Browser, title: String?) {
    }
    
    func onFaviconURLChange(browser: Browser, iconURLs: [NSURL]?) {
    }
    
    func onTooltip(browser: Browser, inout text: String?) -> OnTooltipAction {
        return .ShowDefault
    }
    
    func onStatusMessage(browser: Browser, text: String) {
    }
    
    func onConsoleMessage(browser: Browser,
                          message: String?,
                          source: String?,
                          lineNumber: Int) -> OnConsoleMessageAction {
        return .Allow
    }

}

