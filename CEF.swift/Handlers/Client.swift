//
//  Client.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations.
public protocol Client {

    /// Return the handler for context menus. If no handler is provided the default
    /// implementation will be used.
    var contextMenuHandler: ContextMenuHandler? { get }

    /// Return the handler for dialogs. If no handler is provided the default
    /// implementation will be used.
    var dialogHandler: DialogHandler? { get }
    
    /// Return the handler for browser display state events.
    var displayHandler: DisplayHandler? { get }
    
    /// Return the handler for download events. If no handler is returned downloads
    /// will not be allowed.
    var downloadHandler: DownloadHandler? { get }
    
    /// Return the handler for drag events.
    var dragHandler: DragHandler? { get }
    
    /// Return the handler for find result events.
    var findHandler: FindHandler? { get }
    
    /// Return the handler for focus events.
    var focusHandler: FocusHandler? { get }
    
    /// Return the handler for geolocation permissions requests. If no handler is
    /// provided geolocation access will be denied by default.
    var geolocationHandler: GeolocationHandler? { get }
    
    /// Return the handler for JavaScript dialogs. If no handler is provided the
    /// default implementation will be used.
    var jsDialogHandler: JSDialogHandler? { get }
    
    /// Return the handler for keyboard events.
    var keyboardHandler: KeyboardHandler? { get }
    
    /// Return the handler for browser life span events.
    var lifeSpanHandler: LifeSpanHandler? { get }
    
    /// Return the handler for browser load status events.
    var loadHandler: LoadHandler? { get }
    
    /// Return the handler for off-screen rendering events.
    var renderHandler: RenderHandler? { get }
    
    /// Return the handler for browser request events.
    var requestHandler: RequestHandler? { get }
    
    /// Called when a new message is received from a different process. Return true
    /// if the message was handled or false otherwise. Do not keep a reference to
    /// or attempt to access the message outside of this callback.
    func onProcessMessageReceived(browser: Browser,
                                  processID: ProcessID,
                                  message: ProcessMessage) -> OnProcessMessageReceivedAction
    
}

public extension Client {

    var contextMenuHandler: ContextMenuHandler? { return nil }
    var dialogHandler: DialogHandler? { return nil }
    var displayHandler: DisplayHandler? { return nil }
    var downloadHandler: DownloadHandler? { return nil }
    var dragHandler: DragHandler? { return nil }
    var findHandler: FindHandler? { return nil }
    var focusHandler: FocusHandler? { return nil }
    var geolocationHandler: GeolocationHandler? { return nil }
    var jsDialogHandler: JSDialogHandler? { return nil }
    var keyboardHandler: KeyboardHandler? { return nil }
    var lifeSpanHandler: LifeSpanHandler? { return nil }
    var loadHandler: LoadHandler? { return nil }
    var renderHandler: RenderHandler? { return nil }
    var requestHandler: RequestHandler? { return nil }
    
    func onProcessMessageReceived(browser: Browser,
                                  processID: ProcessID,
                                  message: ProcessMessage) -> OnProcessMessageReceivedAction {
        return .PassThrough
    }

}


