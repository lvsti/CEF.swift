//
//  CEFDisplayHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnConsoleMessageAction {
    case allow
    case cancel
}

public enum CEFOnTooltipAction {
    case showDefault
    case showCustom
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
    
    /// Called when web content in the page has toggled fullscreen mode. If
    /// |fullscreen| is true (1) the content will automatically be sized to fill
    /// the browser content area. If |fullscreen| is false (0) the content will
    /// automatically return to its original size and position. The client is
    /// responsible for resizing the browser if desired.
    func onFullscreenModeChange(browser: CEFBrowser, fullscreen: Bool)
    
    /// Called when the browser is about to display a tooltip. |text| contains the
    /// text that will be displayed in the tooltip. To handle the display of the
    /// tooltip yourself return true. Otherwise, you can optionally modify |text|
    /// and then return false to allow the browser to display the tooltip.
    /// When window rendering is disabled the application is responsible for
    /// drawing tooltips and the return value is ignored.
    func onTooltip(browser: CEFBrowser, text: inout String?) -> CEFOnTooltipAction
    
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

    func onFullscreenModeChange(browser: CEFBrowser, fullscreen: Bool) {
    }

    func onTooltip(browser: CEFBrowser, text: inout String?) -> CEFOnTooltipAction {
        return .showDefault
    }
    
    func onStatusMessage(browser: CEFBrowser, text: String) {
    }
    
    func onConsoleMessage(browser: CEFBrowser,
                          message: String?,
                          source: String?,
                          lineNumber: Int) -> CEFOnConsoleMessageAction {
        return .allow
    }

}

