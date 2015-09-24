//
//  JSDialogHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum OnJSDialogAction {
    /// Suppress the message
    case Suppress
    
    /// Use the default implementation
    case ShowDefault
    
    /// Show a custom dialog
    case ShowCustom
    
    /// Consume the event, no dialog is shown
    case Consume
}

extension OnJSDialogAction: BooleanType {
    public var boolValue: Bool { return self == .ShowCustom || self == .Consume }
}

public enum OnBeforeUnloadDialogAction {
    case ShowDefault
    case ShowCustom
    case Consume
}

extension OnBeforeUnloadDialogAction: BooleanType {
    public var boolValue: Bool { return self == .ShowCustom || self == .Consume }
}

/// Implement this interface to handle events related to JavaScript dialogs. The
/// methods of this class will be called on the UI thread.
public protocol JSDialogHandler {
    
    /// Called to run a JavaScript dialog. The |default_prompt_text| value will be
    /// specified for prompt dialogs only. Set |suppress_message| to true and
    /// return false to suppress the message (suppressing messages is preferable
    /// to immediately executing the callback as this is used to detect presumably
    /// malicious behavior like spamming alert messages in onbeforeunload). Set
    /// |suppress_message| to false and return false to use the default
    /// implementation (the default implementation will show one modal dialog at a
    /// time and suppress any additional dialog requests until the displayed dialog
    /// is dismissed). Return true if the application will use a custom dialog or
    /// if the callback has been executed immediately. Custom dialogs may be either
    /// modal or modeless. If a custom dialog is used the application must execute
    /// |callback| once the custom dialog is dismissed.
    func onJSDialog(browser: Browser,
                    origin: NSURL?,
                    acceptLanguage: String?,
                    type: JSDialogType,
                    message: String?,
                    prompt: String?,
                    callback: JSDialogCallback) -> OnJSDialogAction
    
    /// Called to run a dialog asking the user if they want to leave a page. Return
    /// false to use the default dialog implementation. Return true if the
    /// application will use a custom dialog or if the callback has been executed
    /// immediately. Custom dialogs may be either modal or modeless. If a custom
    /// dialog is used the application must execute |callback| once the custom
    /// dialog is dismissed.
    func onBeforeUnloadDialog(browser: Browser,
                              message: String?,
                              isReload: Bool,
                              callback: JSDialogCallback) -> OnBeforeUnloadDialogAction
    
    /// Called to cancel any pending dialogs and reset any saved dialog state. Will
    /// be called due to events like page navigation irregardless of whether any
    /// dialogs are currently pending.
    func onResetDialogState(browser: Browser)
    
    /// Called when the default implementation dialog is closed.
    func onDialogClosed(browser: Browser)

}

public extension JSDialogHandler {

    func onJSDialog(browser: Browser,
                    origin: NSURL?,
                    acceptLanguage: String?,
                    type: JSDialogType,
                    message: String?,
                    prompt: String?,
                    callback: JSDialogCallback) -> OnJSDialogAction {
        return .ShowDefault
    }

    func onBeforeUnloadDialog(browser: Browser,
                              message: String?,
                              isReload: Bool,
                              callback: JSDialogCallback) -> OnBeforeUnloadDialogAction {
        return .ShowDefault
    }

    func onResetDialogState(browser: Browser) {
    }
    
    func onDialogClosed(browser: Browser) {
    }

}
