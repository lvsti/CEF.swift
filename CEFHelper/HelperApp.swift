//
//  HelperApp.swift
//  CEFHelper
//
//  Created by Morris on 22/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation
import CEFswift

class HelperApp: CEFApp, CEFRenderProcessHandler {
    var renderProcessHandler: CEFRenderProcessHandler? { return self }

    /// Provides an opportunity to register custom schemes. Do not keep a reference
    /// to the |registrar| object. This method is called on the main thread for
    /// each process and the registered schemes should be the same across all
    /// processes.
    /// CEF name: `OnRegisterCustomSchemes`
    func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar) {
        // TODO: Implement custom scheme. However, custom scheme will cause some issue for web storage API.
    }

    /// Called when a new node in the the browser gets focus. The |node| value may
    /// be empty if no specific node has gained focus. The node object passed to
    /// this method represents a snapshot of the DOM at the time this method is
    /// executed. DOM objects are only valid for the scope of this method. Do not
    /// keep references to or attempt to access any DOM objects outside the scope
    /// of this method.
    /// CEF name: `OnFocusedNodeChanged`
    func onFocusedNodeChanged(browser: CEFBrowser, frame: CEFFrame?, node: CEFDOMNode?) {
        // TODO: Notify main process that focused node changed.
        // We only should enable this method by a flag just like CEFsharp.
    }

    /// Called immediately after the V8 context for a frame has been created. To
    /// retrieve the JavaScript 'window' object use the CefV8Context::GetGlobal()
    /// method. V8 handles can only be accessed from the thread on which they are
    /// created. A task runner for posting tasks on the associated thread can be
    /// retrieved via the CefV8Context::GetTaskRunner() method.
    /// CEF name: `OnContextCreated`
    func onContextCreated(browser: CEFBrowser, frame: CEFFrame) {
        if frame.isMain, let message = CEFProcessMessage(.onContextCreatedRequest) {
            message.argumentList?.set(Double(frame.identifier), at: 0)
            browser.sendProcessMessage(targetProcessID: CEFProcessID.browser, message: message)
        }
        // TODO: Might also support other frame.
        // TODO: Start bind object to webpage
    }

    /// Called immediately before the V8 context for a frame is released. No
    /// references to the context should be kept after this method is called.
    /// CEF name: `OnContextReleased`
    func onContextReleased(browser: CEFBrowser,
                           frame: CEFFrame,
                           context: CEFV8Context) {
        if frame.isMain, let message = CEFProcessMessage(.onContextReleasedRequest) {
            message.argumentList?.set(Double(frame.identifier), at: 0)
            browser.sendProcessMessage(targetProcessID: CEFProcessID.browser, message: message)
        }
        // TODO: Cleanup bounded object
    }

    /// Called for global uncaught exceptions in a frame. Execution of this
    /// callback is disabled by default. To enable set
    /// CefSettings.uncaught_exception_stack_size > 0.
    /// CEF name: `OnUncaughtException`
    func onUncaughtException(browser: CEFBrowser,
                             frame: CEFFrame,
                             exception: ICEFV8Exception,
                             stackTrace: ICEFV8StackTrace) {
        guard let message = CEFProcessMessage(.onUncaughtException) else { return }
        guard let list = message.argumentList else { return }
//        guard let frames = CEFListValue() else { return }
//
//        var i = 0
//        while i < stackTrace.frameCount {
//            if let farg = stackTrace.frame(at: i), let frame = CEFListValue() {
//                frame.set(farg.functionName, at: 0)
//                frame.set(farg.lineNumber ?? 0, at: 1)
//                frame.set(farg.column ?? 0, at: 2)
//                frame.set(farg.scriptNameOrSourceURL, at: 3)
//
//                frames.set(frame, at: i)
//            }
//            i += 1
//        }

        list.set(Int(frame.identifier), at: 0)
        list.set(exception.message, at: 1)
        list.set(exception.lineNumber, at: 2)
        list.set(exception.startPosition, at: 3)
        list.set(exception.endPosition, at: 4)
        list.set(exception.startColumn, at: 5)
        list.set(exception.endColumn, at: 6)
//        list.set(frames, at: 7)

        browser.sendProcessMessage(targetProcessID: .browser, message: message)
    }

    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
    /// CEF name: `OnProcessMessageReceived`
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        return .passThrough
    }
}
