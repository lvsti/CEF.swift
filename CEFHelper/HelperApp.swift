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
        if frame.isMain,
           let message = CEFProcessMessage(.onContextCreatedRequest),
           let wrapper = CEFBrowserWrapper.getFrameWrapper(bid: browser.identifier, fid: frame.identifier) {
            wrapper.contextCreated = true

            tryBoundObject(browser, fid: frame.identifier)

            message.argumentList?.set(frame.identifier as Int64, at: 0)
            browser.sendProcessMessage(targetProcessID: CEFProcessID.browser, message: message)
        }
    }

    /// Called immediately before the V8 context for a frame is released. No
    /// references to the context should be kept after this method is called.
    /// CEF name: `OnContextReleased`
    func onContextReleased(browser: CEFBrowser, frame: CEFFrame) {
        if frame.isMain,
           let message = CEFProcessMessage(.onContextReleasedRequest),
           let wrapper = CEFBrowserWrapper.getFrameWrapper(bid: browser.identifier, fid: frame.identifier) {

            // Mark wrapper as uninited, which it will cleanup V8 resources.
            wrapper.contextCreated = false

            message.argumentList?.set(frame.identifier as Int64, at: 0)
            browser.sendProcessMessage(targetProcessID: CEFProcessID.browser, message: message)
        }
    }

    private func tryBoundObject(_ browser: CEFBrowser, fid: CEFFrame.Identifier) {
        if let wrapper = CEFBrowserWrapper.getFrameWrapper(bid: browser.identifier, fid: fid),
           wrapper.contextCreated,
           let f = browser.frame(id: fid) {
            // Must assign the v8Context to a variable, because CEFFrame.v8Context always
            // returns a new v8Context object.
            let context = f.v8Context
            if !context.enter() { return }

            for delegate in wrapper.boundObjectDelegates.values {
                if delegate.bound { continue }
                delegate.bound = true

                guard let boundObject = CEFV8Value.createObject() else { continue }

                // Bound to window
                for m in delegate.methods {
                    boundObject.setValue(
                        CEFV8Value.createFunction(name: m, handler: delegate)!,
                        for: m,
                        attribute: CEFV8PropertyAttribute.none
                    )
                }

                context.globalObject?.setValue(boundObject, for: delegate.name, attribute: CEFV8PropertyAttribute.none)
            }

            context.exit()
        }
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

        list.set(frame.identifier as Int64, at: 0) // Uses two slot to store Int64
        list.set(exception.message, at: 1)
        list.set(exception.lineNumber, at: 2)
        list.set(exception.startPosition, at: 3)
        list.set(exception.endPosition, at: 4)
        list.set(exception.startColumn, at: 5)
        list.set(exception.endColumn, at: 6)
//        list.set(frames, at: 7)

        browser.sendProcessMessage(targetProcessID: .browser, message: message)
    }

    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {

        guard
            !CEFSettings.CEFSingleProcessMode,
            case .browser = processID,
            let msg = CEFProcessMessage.Message(rawValue: message.name)
        else {
            return .passThrough
        }

        switch msg {
            case .javascriptObjectsBoundInJavascript:
                // Register bound object
                // Ask Renderer Process to bound js object.
                guard let arguments = message.argumentList else {
                    print("[CEFswift ERR] Cannot get IPC message args")
                    return .passThrough
                }

                let fid = arguments.int64(at: 0)
                if let objName = arguments.string(at: 1),
                   let methods = arguments.stringArray(at: 2),
                   let wrapper = CEFBrowserWrapper.getFrameWrapper(bid: browser.identifier, fid: fid) {
                    wrapper.boundObjectDelegates[objName] = CEFBoundObjectDelegate(
                        name: objName,
                        methods: methods,
                        browser: browser,
                        fid: fid
                    )
                    tryBoundObject(browser, fid: fid)
                }
                return .consume
            case .javascriptAsyncMethodCallResponse:
                // Js to Native returns.
                guard let arguments = message.argumentList else {
                    print("[CEFswift ERR] Cannot get IPC message args")
                    return .passThrough
                }

                let fid = arguments.int64(at: 0)
                let requestId = arguments.int32(at: 1)
                let resultType = arguments.int32(at: 2)

                var errorStr = resultType == 0 ? arguments.string(at: 3) : nil
                var result = resultType == 2 ? arguments.value(at: 3) : nil

                if let f = browser.frame(id: fid) {
                    guard let wrapper = CEFBrowserWrapper.getFrameWrapper(bid: browser.identifier, fid: fid) else {
                        return .consume
                    }

                    // Always store v8 Context in a variable, anonymous variable will be release immediately
                    // cause a inbalanced exit() exception.
                    let context = f.v8Context
                    context.enter()
                    defer { context.exit() }
                    if resultType == 0 {
                        wrapper.rejectPromise(requestId, errorStr ?? "Unknown error")
                    } else {
                        wrapper.resolvePromise(requestId, result)
                    }
                }

                return .consume
            
            default:
                break
        }

        return .passThrough
    }
}
