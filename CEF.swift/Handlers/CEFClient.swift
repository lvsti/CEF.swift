//
//  CEFClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations.
/// CEF name: `CefClient`
public protocol CEFClient {

    /// Return the handler for context menus. If no handler is provided the default
    /// implementation will be used.
    /// CEF name: `GetContextMenuHandler`
    var contextMenuHandler: CEFContextMenuHandler? { get }

    /// Return the handler for dialogs. If no handler is provided the default
    /// implementation will be used.
    /// CEF name: `GetDialogHandler`
    var dialogHandler: CEFDialogHandler? { get }
    
    /// Return the handler for browser display state events.
    /// CEF name: `GetDisplayHandler`
    var displayHandler: CEFDisplayHandler? { get }
    
    /// Return the handler for download events. If no handler is returned downloads
    /// will not be allowed.
    /// CEF name: `GetDownloadHandler`
    var downloadHandler: CEFDownloadHandler? { get }
    
    /// Return the handler for drag events.
    /// CEF name: `GetDragHandler`
    var dragHandler: CEFDragHandler? { get }
    
    /// Return the handler for find result events.
    /// CEF name: `GetFindHandler`
    var findHandler: CEFFindHandler? { get }
    
    /// Return the handler for focus events.
    /// CEF name: `GetFocusHandler`
    var focusHandler: CEFFocusHandler? { get }
    
    /// Return the handler for geolocation permissions requests. If no handler is
    /// provided geolocation access will be denied by default.
    /// CEF name: `GetGeolocationHandler`
    var geolocationHandler: CEFGeolocationHandler? { get }
    
    /// Return the handler for JavaScript dialogs. If no handler is provided the
    /// default implementation will be used.
    /// CEF name: `GetJSDialogHandler`
    var jsDialogHandler: CEFJSDialogHandler? { get }
    
    /// Return the handler for keyboard events.
    /// CEF name: `GetKeyboardHandler`
    var keyboardHandler: CEFKeyboardHandler? { get }
    
    /// Return the handler for browser life span events.
    /// CEF name: `GetLifeSpanHandler`
    var lifeSpanHandler: CEFLifeSpanHandler? { get }
    
    /// Return the handler for browser load status events.
    /// CEF name: `GetLoadHandler`
    var loadHandler: CEFLoadHandler? { get }
    
    /// Return the handler for off-screen rendering events.
    /// CEF name: `GetRenderHandler`
    var renderHandler: CEFRenderHandler? { get }
    
    /// Return the handler for browser request events.
    /// CEF name: `GetRequestHandler`
    var requestHandler: CEFRequestHandler? { get }
    
    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
    /// CEF name: `OnProcessMessageReceived`
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction
    
}

public extension CEFClient {

    var contextMenuHandler: CEFContextMenuHandler? { return nil }
    var dialogHandler: CEFDialogHandler? { return nil }
    var displayHandler: CEFDisplayHandler? { return nil }
    var downloadHandler: CEFDownloadHandler? { return nil }
    var dragHandler: CEFDragHandler? { return nil }
    var findHandler: CEFFindHandler? { return nil }
    var focusHandler: CEFFocusHandler? { return nil }
    var geolocationHandler: CEFGeolocationHandler? { return nil }
    var jsDialogHandler: CEFJSDialogHandler? { return nil }
    var keyboardHandler: CEFKeyboardHandler? { return nil }
    var lifeSpanHandler: CEFLifeSpanHandler? { return nil }
    var loadHandler: CEFLoadHandler? { return nil }
    var renderHandler: CEFRenderHandler? { return nil }
    var requestHandler: CEFRequestHandler? { return nil }
    
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {

        guard
            !CEFSettings.CEFSingleProcessMode,
            case .renderer = processID,
            let msg = CEFProcessMessage.Message(rawValue: message.name),
            let cefapp = CEFProcessUtils.cefapp
        else {
            return .passThrough
        }

        print(browser, processID, message.name)

        switch msg {
            case .javascriptAsyncMethodCallRequest:
                break
            case .javascriptAsyncMethodCallResponse:
                break
            case .onContextCreatedRequest:
                if let rph = cefapp.renderProcessHandler,
                   let fid = message.argumentList?.int64(at: 0),
                   let frame = browser.frame(id: fid) {
                    rph.onContextCreated(browser: browser, frame: frame)
                }
            case .onContextReleasedRequest:
                if let fid = message.argumentList?.int64(at: 0) {
                    // Free bounded object.
                    CEFBrowserWrapper.getWrapper(browser.identifier).removeFrameWrapper(fid)

                    if let rph = cefapp.renderProcessHandler,
                       let frame = browser.frame(id: fid) {
                        rph.onContextReleased(browser: browser, frame: frame)
                    }
                }
            case .onUncaughtException:
                if let args = message.argumentList,
                   let frame = browser.frame(id: args.int64(at: 0)),
                   let rph = cefapp.renderProcessHandler {

                    let e = CEFV8ExceptionWrapper()
                    e.message = args.string(at: 2) ?? ""
                    e.lineNumber = args.int(at: 3)
                    e.startPosition = args.int(at: 4)
                    e.endPosition = args.int(at: 5)
                    e.startColumn = args.int(at: 6)
                    e.endColumn = args.int(at: 7)

                    rph.onUncaughtException(
                        browser: browser,
                        frame: frame,
                        exception: e,
                        stackTrace: CEFV8StackTraceWrapper()
                    )
                }
            default:
                break
        }

        return .consume
    }

}


