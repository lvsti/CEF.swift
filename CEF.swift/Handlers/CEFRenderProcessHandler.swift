//
//  CEFRenderProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnBeforeNavigationAction {
    case Allow
    case Cancel
}

extension CEFOnBeforeNavigationAction: BooleanType {
    public var boolValue: Bool { return self == .Cancel }
}

public enum CEFOnProcessMessageReceivedAction {
    case Consume
    case PassThrough
}

extension CEFOnProcessMessageReceivedAction: BooleanType {
    public var boolValue: Bool { return self == .Consume }
}

/// Class used to implement render process callbacks. The methods of this class
/// will be called on the render process main thread (TID_RENDERER) unless
/// otherwise indicated.
public protocol CEFRenderProcessHandler {

    /// Called after the render process main thread has been created. |extra_info|
    /// is a read-only value originating from
    /// CefBrowserProcessHandler::OnRenderProcessThreadCreated(). Do not keep a
    /// reference to |extra_info| outside of this method.
    func onRenderThreadCreated(info: CEFListValue)
    
    /// Called after WebKit has been initialized.
    func onWebKitInitialized()
    
    /// Called after a browser has been created. When browsing cross-origin a new
    /// browser will be created before the old browser with the same identifier is
    /// destroyed.
    func onBrowserCreated(browser: CEFBrowser)
    
    /// Called before a browser is destroyed.
    func onBrowserDestroyed(browser: CEFBrowser)
    
    /// Return the handler for browser load status events.
    var loadHandler: CEFLoadHandler? { get }
    
    /// Called before browser navigation. Return true to cancel the navigation or
    /// false to allow the navigation to proceed. The |request| object cannot be
    /// modified in this callback.
    func onBeforeNavigation(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            navigationType: CEFNavigationType,
                            isRedirect: Bool) -> CEFOnBeforeNavigationAction
    
    /// Called immediately after the V8 context for a frame has been created. To
    /// retrieve the JavaScript 'window' object use the CefV8Context::GetGlobal()
    /// method. V8 handles can only be accessed from the thread on which they are
    /// created. A task runner for posting tasks on the associated thread can be
    /// retrieved via the CefV8Context::GetTaskRunner() method.
    func onContextCreated(browser: CEFBrowser,
                          frame: CEFFrame,
                          context: CEFV8Context)
    
    /// Called immediately before the V8 context for a frame is released. No
    /// references to the context should be kept after this method is called.
    func onContextReleased(browser: CEFBrowser,
                           frame: CEFFrame,
                           context: CEFV8Context)
    
    /// Called for global uncaught exceptions in a frame. Execution of this
    /// callback is disabled by default. To enable set
    /// CefSettings.uncaught_exception_stack_size > 0.
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
    func onFocusedNodeChanged(browser: CEFBrowser,
                              frame: CEFFrame?,
                              node: CEFDOMNode?)
    
    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction
    
}

public extension CEFRenderProcessHandler {
    
    func onRenderThreadCreated(info: CEFListValue) {
    }
    
    func onWebKitInitialized() {
    }
    
    func onBrowserCreated(browser: CEFBrowser) {
    }
    
    func onBrowserDestroyed(browser: CEFBrowser) {
    }
    
    var loadHandler: CEFLoadHandler? { return nil }
    
    func onBeforeNavigation(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            navigationType: CEFNavigationType,
                            isRedirect: Bool) -> CEFOnBeforeNavigationAction {
        return .Allow
    }
    
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
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        return .PassThrough
    }
    
}
