//
//  CEFClient.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_client_t: CEFObject {
}

class CEFClientMarshaller: CEFMarshaller<cef_client_t, CEFClient> {
    override init(obj: CEFClient) {
        super.init(obj: obj)
    }
}

public class CEFClient: CEFHandler {
    
    public override init() {
        super.init()
    }

    /*
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
*/
    
    func toCEF() -> UnsafeMutablePointer<cef_client_t> {
        return CEFClientMarshaller.pass(self)
    }
}


