//
//  CEFClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_client_t: CEFObject {
}

typealias CEFClientMarshaller = CEFMarshaller<CEFClient, cef_client_t>

extension CEFClient {
    func toCEF() -> UnsafeMutablePointer<cef_client_t> {
        return CEFClientMarshaller.pass(self)
    }
}

extension cef_client_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_context_menu_handler = CEFClient_getContextMenuHandler
//        cefStruct.get_dialog_handler
        get_display_handler = CEFClient_getDisplayHandler
        get_download_handler = CEFClient_getDownloadHandler
//        cefStruct.get_drag_handler
//        cefStruct.get_find_handler
        get_focus_handler = CEFClient_getFocusHandler
//        cefStruct.get_geolocation_handler
//        cefStruct.get_jsdialog_handler
//        cefStruct.get_keyboard_handler
        get_life_span_handler = CEFClient_getLifeSpanHandler
        get_load_handler = CEFClient_getLoadHandler
//        cefStruct.get_render_handler
        get_request_handler = CEFClient_getRequestHandler
        on_process_message_received = CEFClient_onProcessMessageReceived
    }
}

func CEFClient_getContextMenuHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_context_menu_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getContextMenuHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getDisplayHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_display_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getDisplayHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getDownloadHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_download_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getDownloadHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getFocusHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_focus_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getFocusHandler() {
        return handler.toCEF()
    }
    
    return nil
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

func CEFClient_getLoadHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_load_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getLoadHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getRequestHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_request_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getRequestHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_onProcessMessageReceived(ptr: UnsafeMutablePointer<cef_client_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        source: cef_process_id_t,
                                        message: UnsafeMutablePointer<cef_process_message_t>) -> Int32 {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return 0
    }

    return obj.onProcessMessageReceived(CEFBrowser.fromCEF(browser)!,
                                        processID: CEFProcessID.fromCEF(source),
                                        message: CEFProcessMessage.fromCEF(message)!) ? 1 : 0
}

