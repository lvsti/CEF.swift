//
//  CEFDisplayHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnConsoleMessageAction {
    case Allow
    case Cancel
}

extension CEFOnConsoleMessageAction: BooleanType {
    public var boolValue: Bool { return self == .Cancel }
}

public enum CEFOnTooltipAction {
    case ShowDefault
    case ShowCustom
}

extension CEFOnTooltipAction: BooleanType {
    public var boolValue: Bool { return self == .ShowCustom }
}

/// Implement this interface to handle events related to browser display state.
/// The methods of this class will be called on the UI thread.
public protocol CEFDisplayHandler {
    /// Called when a frame's address has changed.
    func onAddressChange(browser: CEFBrowser, frame: CEFFrame, url: NSURL)
    
    /// Called when the page title changes.
    func onTitleChange(browser: CEFBrowser, title: String?)
    
    /// Called when the page icon changes.
    func onFaviconURLChange(browser: CEFBrowser, iconURLs: [NSURL]?)
    
    /// Called when the browser is about to display a tooltip. |text| contains the
    /// text that will be displayed in the tooltip. To handle the display of the
    /// tooltip yourself return true. Otherwise, you can optionally modify |text|
    /// and then return false to allow the browser to display the tooltip.
    /// When window rendering is disabled the application is responsible for
    /// drawing tooltips and the return value is ignored.
    func onTooltip(browser: CEFBrowser, inout text: String?) -> CEFOnTooltipAction
    
    /// Called when the browser receives a status message. |value| contains the
    /// text that will be displayed in the status message.
    func onStatusMessage(browser: CEFBrowser, text: String?)
    
    /// Called to display a console message. Return true to stop the message from
    /// being output to the console.
    func onConsoleMessage(browser: CEFBrowser,
                          message: String?,
                          source: String?,
                          lineNumber: Int) -> CEFOnConsoleMessageAction

}

public extension CEFDisplayHandler {

    func onAddressChange(browser: CEFBrowser, frame: CEFFrame, url: NSURL) {
    }
    
    func onTitleChange(browser: CEFBrowser, title: String?) {
    }
    
    func onFaviconURLChange(browser: CEFBrowser, iconURLs: [NSURL]?) {
    }
    
    func onTooltip(browser: CEFBrowser, inout text: String?) -> CEFOnTooltipAction {
        return .ShowDefault
    }
    
    func onStatusMessage(browser: CEFBrowser, text: String) {
    }
    
    func onConsoleMessage(browser: CEFBrowser,
                          message: String?,
                          source: String?,
                          lineNumber: Int) -> CEFOnConsoleMessageAction {
        return .Allow
    }

}

