//
//  CEFClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Implement this interface to provide handler implementations.
///
public protocol CEFClient {

    ///
    // Return the handler for context menus. If no handler is provided the default
    // implementation will be used.
    ///
    func getContextMenuHandler() -> CEFContextMenuHandler?

    ///
    // Return the handler for dialogs. If no handler is provided the default
    // implementation will be used.
    ///
    func getDialogHandler() -> CEFDialogHandler?
    
    ///
    // Return the handler for browser display state events.
    ///
    func getDisplayHandler() -> CEFDisplayHandler?
    
    ///
    // Return the handler for download events. If no handler is returned downloads
    // will not be allowed.
    ///
    func getDownloadHandler() -> CEFDownloadHandler?
    
    ///
    // Return the handler for drag events.
    ///
    func getDragHandler() -> CEFDragHandler?
    
    ///
    // Return the handler for find result events.
    ///
    func getFindHandler() -> CEFFindHandler?
    
    ///
    // Return the handler for focus events.
    ///
    func getFocusHandler() -> CEFFocusHandler?
    
    ///
    // Return the handler for geolocation permissions requests. If no handler is
    // provided geolocation access will be denied by default.
    ///
    func getGeolocationHandler() -> CEFGeolocationHandler?
    
    ///
    // Return the handler for JavaScript dialogs. If no handler is provided the
    // default implementation will be used.
    ///
    func getJSDialogHandler() -> CEFJSDialogHandler?
    
    ///
    // Return the handler for keyboard events.
    ///
    func getKeyboardHandler() -> CEFKeyboardHandler?
    
    ///
    // Return the handler for browser life span events.
    ///
    func getLifeSpanHandler() -> CEFLifeSpanHandler?
    
    ///
    // Return the handler for browser load status events.
    ///
    func getLoadHandler() -> CEFLoadHandler?
    
    ///
    // Return the handler for off-screen rendering events.
    ///
    func getRenderHandler() -> CEFRenderHandler?
    
    ///
    // Return the handler for browser request events.
    ///
    func getRequestHandler() -> CEFRequestHandler?
    
    ///
    // Called when a new message is received from a different process. Return true
    // if the message was handled or false otherwise. Do not keep a reference to
    // or attempt to access the message outside of this callback.
    ///
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> Bool
    
}

public extension CEFClient {

    func getContextMenuHandler() -> CEFContextMenuHandler? {
        return nil
    }

    func getDialogHandler() -> CEFDialogHandler? {
        return nil
    }
    
    func getDisplayHandler() -> CEFDisplayHandler? {
        return nil
    }
    
    func getDownloadHandler() -> CEFDownloadHandler? {
        return nil
    }

    func getDragHandler() -> CEFDragHandler? {
        return nil
    }

    func getFindHandler() -> CEFFindHandler? {
        return nil
    }

    func getFocusHandler() -> CEFFocusHandler? {
        return nil
    }

    func getGeolocationHandler() -> CEFGeolocationHandler? {
        return nil
    }

    func getJSDialogHandler() -> CEFJSDialogHandler? {
        return nil
    }

    func getKeyboardHandler() -> CEFKeyboardHandler? {
        return nil
    }
    
    func getLifeSpanHandler() -> CEFLifeSpanHandler? {
        return nil
    }
    
    func getLoadHandler() -> CEFLoadHandler? {
        return nil
    }

    func getRenderHandler() -> CEFRenderHandler? {
        return nil
    }

    func getRequestHandler() -> CEFRequestHandler? {
        return nil
    }

    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> Bool {
        return false
    }

}


