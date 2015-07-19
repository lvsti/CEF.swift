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

public class CEFClient: CEFHandlerBase<cef_client_t>, CEFObjectLookup {
    typealias SelfType = CEFClient
    
    static var _registryLock: Lock = CEFClient.createLock()
    static var _registry = Dictionary<ObjectPtrType, SelfType>()
    
    public init?() {
        let handler = ObjectPtrType.alloc(1)
        handler.memory.base.add_ref = CEFClient_addRef
        handler.memory.base.release = CEFClient_release
        handler.memory.base.has_one_ref = CEFClient_hasOneRef
        
        super.init(ptr: handler)
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
}


func CEFClient_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let wrapper = CEFClient.lookup(CEFClient.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.addRef()
}

func CEFClient_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFClient.lookup(CEFClient.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.release() ? 1 : 0
}

func CEFClient_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFClient.lookup(CEFClient.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.hasOneRef() ? 1 : 0
}

