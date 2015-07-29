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

typealias CEFClientMarshaller = CEFMarshaller<CEFClient>

public class CEFClient: CEFHandler, CEFMarshallable {
    typealias StructType = cef_client_t

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
*/
    public func getLifeSpanHandler() -> CEFLifeSpanHandler? {
        return nil
    }
/*
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
    
    func marshalCallbacks(inout cefStruct: cef_client_t) {
//        cefStruct.get_context_menu_handler
//        cefStruct.get_dialog_handler
//        cefStruct.get_display_handler
//        cefStruct.get_download_handler
//        cefStruct.get_drag_handler
//        cefStruct.get_find_handler
//        cefStruct.get_focus_handler
//        cefStruct.get_geolocation_handler
//        cefStruct.get_jsdialog_handler
//        cefStruct.get_keyboard_handler
        cefStruct.get_life_span_handler = CEFClient_getLifeSpanHandler
//        cefStruct.get_load_handler
//        cefStruct.get_render_handler
//        cefStruct.get_request_handler
//        cefStruct.on_process_message_received
    }
}

func CEFClient_getLifeSpanHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_life_span_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getLifeSpanHandler() {
        return handler.toCEF()
    }
    
    return nil
}



