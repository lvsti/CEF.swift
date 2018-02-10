//
//  CEFJSDialogHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnJSDialogAction {
    /// Suppress the message
    case suppress
    
    /// Use the default implementation
    case showDefault
    
    /// Show a custom dialog
    case showCustom
    
    /// Consume the event, no dialog is shown
    case consume
}

public enum CEFOnBeforeUnloadDialogAction {
    case showDefault
    case showCustom
    case consume
}

/// Implement this interface to handle events related to JavaScript dialogs. The
/// methods of this class will be called on the UI thread.
/// CEF name: `CefJSDialogHandler`
public protocol CEFJSDialogHandler {
    
    /// Called to run a JavaScript dialog. If |origin_url| is non-empty it can be
    /// passed to the CefFormatUrlForSecurityDisplay function to retrieve a secure
    /// and user-friendly display string. The |default_prompt_text| value will be
    /// specified for prompt dialogs only. Set |suppress_message| to true and
    /// return false to suppress the message (suppressing messages is preferable to
    /// immediately executing the callback as this is used to detect presumably
    /// malicious behavior like spamming alert messages in onbeforeunload). Set
    /// |suppress_message| to false and return false to use the default
    /// implementation (the default implementation will show one modal dialog at a
    /// time and suppress any additional dialog requests until the displayed dialog
    /// is dismissed). Return true if the application will use a custom dialog or
    /// if the callback has been executed immediately. Custom dialogs may be either
    /// modal or modeless. If a custom dialog is used the application must execute
    /// |callback| once the custom dialog is dismissed.
    /// CEF name: `OnJSDialog`
    func onJSDialog(browser: CEFBrowser,
                    origin: NSURL?,
                    type: CEFJSDialogType,
                    message: String?,
                    prompt: String?,
                    callback: CEFJSDialogCallback) -> CEFOnJSDialogAction
    
    /// Called to run a dialog asking the user if they want to leave a page. Return
    /// false to use the default dialog implementation. Return true if the
    /// application will use a custom dialog or if the callback has been executed
    /// immediately. Custom dialogs may be either modal or modeless. If a custom
    /// dialog is used the application must execute |callback| once the custom
    /// dialog is dismissed.
    /// CEF name: `OnBeforeUnloadDialog`
    func onBeforeUnloadDialog(browser: CEFBrowser,
                              message: String?,
                              isReload: Bool,
                              callback: CEFJSDialogCallback) -> CEFOnBeforeUnloadDialogAction
    
    /// Called to cancel any pending dialogs and reset any saved dialog state. Will
    /// be called due to events like page navigation irregardless of whether any
    /// dialogs are currently pending.
    /// CEF name: `OnResetDialogState`
    func onResetDialogState(browser: CEFBrowser)
    
    /// Called when the default implementation dialog is closed.
    /// CEF name: `OnDialogClosed`
    func onDialogClosed(browser: CEFBrowser)

}

public extension CEFJSDialogHandler {

    func onJSDialog(browser: CEFBrowser,
                    origin: NSURL?,
                    type: CEFJSDialogType,
                    message: String?,
                    prompt: String?,
                    callback: CEFJSDialogCallback) -> CEFOnJSDialogAction {
        return .showDefault
    }

    func onBeforeUnloadDialog(browser: CEFBrowser,
                              message: String?,
                              isReload: Bool,
                              callback: CEFJSDialogCallback) -> CEFOnBeforeUnloadDialogAction {
        return .showDefault
    }

    func onResetDialogState(browser: CEFBrowser) {
    }
    
    func onDialogClosed(browser: CEFBrowser) {
    }

}
