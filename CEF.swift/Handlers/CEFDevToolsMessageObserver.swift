//
//  CEFDevToolsMessageObserver.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnDevToolsMessageAction {
    case consume
    case passThrough
}

/// Callback interface for CefBrowserHost::AddDevToolsMessageObserver. The
/// methods of this class will be called on the browser process UI thread.
/// CEF name: `CefDevToolsMessageObserver`
public protocol CEFDevToolsMessageObserver {

    /// Method that will be called on receipt of a DevTools protocol message.
    /// |browser| is the originating browser instance. |message| is a UTF8-encoded
    /// JSON dictionary representing either a method result or an event. |message|
    /// is only valid for the scope of this callback and should be copied if
    /// necessary. Return true if the message was handled or false if the message
    /// should be further processed and passed to the OnDevToolsMethodResult or
    /// OnDevToolsEvent methods as appropriate.
    ///
    /// Method result dictionaries include an "id" (int) value that identifies the
    /// orginating method call sent from CefBrowserHost::SendDevToolsMessage, and
    /// optionally either a "result" (dictionary) or "error" (dictionary) value.
    /// The "error" dictionary will contain "code" (int) and "message" (string)
    /// values. Event dictionaries include a "method" (string) value and optionally
    /// a "params" (dictionary) value. See the DevTools protocol documentation at
    /// https://chromedevtools.github.io/devtools-protocol/ for details of
    /// supported method calls and the expected "result" or "params" dictionary
    /// contents. JSON dictionaries can be parsed using the CefParseJSON function
    /// if desired, however be aware of performance considerations when parsing
    /// large messages (some of which may exceed 1MB in size).
    /// CEF name: `OnDevToolsMessage`
    func onDevToolsMessage(browser: CEFBrowser, message: Data) -> CEFOnDevToolsMessageAction
    
    /// Method that will be called after attempted execution of a DevTools protocol
    /// method. |browser| is the originating browser instance. |message_id| is the
    /// "id" value that identifies the originating method call message. If the
    /// method succeeded |success| will be true and |result| will be the
    /// UTF8-encoded JSON "result" dictionary value (which may be empty). If the
    /// method failed |success| will be false and |result| will be the UTF8-encoded
    /// JSON "error" dictionary value. |result| is only valid for the scope of this
    /// callback and should be copied if necessary. See the OnDevToolsMessage
    /// documentation for additional details on |result| contents.
    /// CEF name: `OnDevToolsMethodResult`
    func onDevToolsMethodResult(browser: CEFBrowser, messageID: Int, success: Bool, result: Data?)
    
    /// Method that will be called on receipt of a DevTools protocol event.
    /// |browser| is the originating browser instance. |method| is the "method"
    /// value. |params| is the UTF8-encoded JSON "params" dictionary value (which
    /// may be empty). |params| is only valid for the scope of this callback and
    /// should be copied if necessary. See the OnDevToolsMessage documentation for
    /// additional details on |params| contents.
    /// CEF name: `OnDevToolsEvent`
    /*--cef(optional_param=params)--*/
    func onDevToolsEvent(browser: CEFBrowser, method: String, parameters: Data?)
    
    /// Method that will be called when the DevTools agent has attached. |browser|
    /// is the originating browser instance. This will generally occur in response
    /// to the first message sent while the agent is detached.
    /// CEF name: `OnDevToolsAgentAttached`
    func onDevToolsAgentAttached(browser: CEFBrowser)
    
    /// Method that will be called when the DevTools agent has detached. |browser|
    /// is the originating browser instance. Any method results that were pending
    /// before the agent became detached will not be delivered, and any active
    /// event subscriptions will be canceled.
    /// CEF name: `OnDevToolsAgentDetached`
    func onDevToolsAgentDetached(browser: CEFBrowser)
}

public extension CEFDevToolsMessageObserver {
    
    func onDevToolsMessage(browser: CEFBrowser, message: Data) -> CEFOnDevToolsMessageAction {
        return .passThrough
    }
    
    func onDevToolsMethodResult(browser: CEFBrowser, messageID: Int, success: Bool, result: Data?) {
    }
    
    func onDevToolsEvent(browser: CEFBrowser, method: String, parameters: Data?) {
    }
    
    func onDevToolsAgentAttached(browser: CEFBrowser) {
    }
    
    func onDevToolsAgentDetached(browser: CEFBrowser) {
    }

}
