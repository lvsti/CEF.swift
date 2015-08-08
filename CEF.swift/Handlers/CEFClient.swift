//
//  CEFClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFClient {

    func getContextMenuHandler() -> CEFContextMenuHandler?
//    func getDialogHandler() -> CEFDialogHandler?
    func getDisplayHandler() -> CEFDisplayHandler?
    func getDownloadHandler() -> CEFDownloadHandler?
//    func getDragHandler() -> CEFDragHandler?
//    func getFindHandler() -> CEFFindHandler?
//    func getFocusHandler() -> CEFFocusHandler?
//    func getGeolocationHandler() -> CEFGeolocationHandler?
//    func getJSDialogHandler() -> CEFJSDialogHandler?
//    func getKeyboardHandler() -> CEFKeyboardHandler?
    func getLifeSpanHandler() -> CEFLifeSpanHandler?
    func getLoadHandler() -> CEFLoadHandler?
//    func getRenderHandler() -> CEFRenderHandler?
    func getRequestHandler() -> CEFRequestHandler?
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> Bool
    
}

public extension CEFClient {

    func getContextMenuHandler() -> CEFContextMenuHandler? {
        return nil
    }
/*
    func getDialogHandler() -> CEFDialogHandler? {
        return nil
    }
*/
    
    func getDisplayHandler() -> CEFDisplayHandler? {
        return nil
    }
    
    func getDownloadHandler() -> CEFDownloadHandler? {
        return nil
    }
/*
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
*/
    func getLifeSpanHandler() -> CEFLifeSpanHandler? {
        return nil
    }
    
    func getLoadHandler() -> CEFLoadHandler? {
        return nil
    }
/*
    func getRenderHandler() -> CEFRenderHandler? {
        return nil
    }
*/
    func getRequestHandler() -> CEFRequestHandler? {
        return nil
    }

    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> Bool {
        return false
    }

}


