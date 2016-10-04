//
//  CEFClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations.
public protocol CEFClient {

    /// Return the handler for context menus. If no handler is provided the default
    /// implementation will be used.
    var contextMenuHandler: CEFContextMenuHandler? { get }

    /// Return the handler for dialogs. If no handler is provided the default
    /// implementation will be used.
    var dialogHandler: CEFDialogHandler? { get }
    
    /// Return the handler for browser display state events.
    var displayHandler: CEFDisplayHandler? { get }
    
    /// Return the handler for download events. If no handler is returned downloads
    /// will not be allowed.
    var downloadHandler: CEFDownloadHandler? { get }
    
    /// Return the handler for drag events.
    var dragHandler: CEFDragHandler? { get }
    
    /// Return the handler for find result events.
    var findHandler: CEFFindHandler? { get }
    
    /// Return the handler for focus events.
    var focusHandler: CEFFocusHandler? { get }
    
    /// Return the handler for geolocation permissions requests. If no handler is
    /// provided geolocation access will be denied by default.
    var geolocationHandler: CEFGeolocationHandler? { get }
    
    /// Return the handler for JavaScript dialogs. If no handler is provided the
    /// default implementation will be used.
    var jsDialogHandler: CEFJSDialogHandler? { get }
    
    /// Return the handler for keyboard events.
    var keyboardHandler: CEFKeyboardHandler? { get }
    
    /// Return the handler for browser life span events.
    var lifeSpanHandler: CEFLifeSpanHandler? { get }
    
    /// Return the handler for browser load status events.
    var loadHandler: CEFLoadHandler? { get }
    
    /// Return the handler for off-screen rendering events.
    var renderHandler: CEFRenderHandler? { get }
    
    /// Return the handler for browser request events.
    var requestHandler: CEFRequestHandler? { get }
    
    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
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
        return .passThrough
    }

}


