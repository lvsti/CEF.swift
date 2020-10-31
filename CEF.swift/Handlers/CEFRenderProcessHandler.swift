//
//  CEFRenderProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnProcessMessageReceivedAction {
    case consume
    case passThrough
}

/// Class used to implement render process callbacks. The methods of this class
/// will be called on the render process main thread (TID_RENDERER) unless
/// otherwise indicated.
/// CEF name: `CefRenderProcessHandler`
public protocol CEFRenderProcessHandler {

    /// Called after WebKit has been initialized.
    /// CEF name: `OnWebKitInitialized`
    func onWebKitInitialized()
    
    /// Called after a browser has been created. When browsing cross-origin a new
    /// browser will be created before the old browser with the same identifier is
    /// destroyed. |extra_info| is a read-only value originating from
    /// CefBrowserHost::CreateBrowser(), CefBrowserHost::CreateBrowserSync(),
    /// CefLifeSpanHandler::OnBeforePopup() or CefBrowserView::CreateBrowserView().
    /// CEF name: `OnBrowserCreated`
    func onBrowserCreated(browser: CEFBrowser, userInfo: CEFDictionaryValue)
    
    /// Called before a browser is destroyed.
    /// CEF name: `OnBrowserDestroyed`
    func onBrowserDestroyed(browser: CEFBrowser)
    
    /// Return the handler for browser load status events.
    /// CEF name: `GetLoadHandler`
    var loadHandler: CEFLoadHandler? { get }
    
    /// Called immediately after the V8 context for a frame has been created. To
    /// retrieve the JavaScript 'window' object use the CefV8Context::GetGlobal()
    /// method. V8 handles can only be accessed from the thread on which they are
    /// created. A task runner for posting tasks on the associated thread can be
    /// retrieved via the CefV8Context::GetTaskRunner() method.
    /// CEF name: `OnContextCreated`
    func onContextCreated(browser: CEFBrowser,
                          frame: CEFFrame,
                          context: CEFV8Context)
    
    /// Called immediately before the V8 context for a frame is released. No
    /// references to the context should be kept after this method is called.
    /// CEF name: `OnContextReleased`
    func onContextReleased(browser: CEFBrowser,
                           frame: CEFFrame,
                           context: CEFV8Context)
    
    /// Called for global uncaught exceptions in a frame. Execution of this
    /// callback is disabled by default. To enable set
    /// CefSettings.uncaught_exception_stack_size > 0.
    /// CEF name: `OnUncaughtException`
    func onUncaughtException(browser: CEFBrowser,
                             frame: CEFFrame,
                             context: CEFV8Context,
                             exception: CEFV8Exception,
                             stackTrace: CEFV8StackTrace)
    
    /// Called when a new node in the the browser gets focus. The |node| value may
    /// be empty if no specific node has gained focus. The node object passed to
    /// this method represents a snapshot of the DOM at the time this method is
    /// executed. DOM objects are only valid for the scope of this method. Do not
    /// keep references to or attempt to access any DOM objects outside the scope
    /// of this method.
    /// CEF name: `OnFocusedNodeChanged`
    func onFocusedNodeChanged(browser: CEFBrowser,
                              frame: CEFFrame?,
                              node: CEFDOMNode?)
    
    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
    /// CEF name: `OnProcessMessageReceived`
    func onProcessMessageReceived(browser: CEFBrowser,
                                  frame: CEFFrame,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction
    
}

public extension CEFRenderProcessHandler {
    
    func onWebKitInitialized() {
    }
    
    func onBrowserCreated(browser: CEFBrowser, userInfo: CEFDictionaryValue) {
    }
    
    func onBrowserDestroyed(browser: CEFBrowser) {
    }
    
    var loadHandler: CEFLoadHandler? { return nil }
    
    func onContextCreated(browser: CEFBrowser,
                          frame: CEFFrame,
                          context: CEFV8Context) {
    }
    
    func onContextReleased(browser: CEFBrowser,
                           frame: CEFFrame,
                           context: CEFV8Context) {
    }
    
    func onUncaughtException(browser: CEFBrowser,
                             frame: CEFFrame,
                             context: CEFV8Context,
                             exception: CEFV8Exception,
                             stackTrace: CEFV8StackTrace) {
    }
    
    func onFocusedNodeChanged(browser: CEFBrowser,
                              frame: CEFFrame?,
                              node: CEFDOMNode?) {
    }
    
    func onProcessMessageReceived(browser: CEFBrowser,
                                  frame: CEFFrame,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        return .passThrough
    }
    
}
