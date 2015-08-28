//
//  CEFClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

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

func CEFClient_getDialogHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_dialog_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getDialogHandler() {
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

func CEFClient_getDragHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_drag_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getDragHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getFindHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_find_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getFindHandler() {
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

func CEFClient_getGeolocationHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_geolocation_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getGeolocationHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getJSDialogHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_jsdialog_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getJSDialogHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_getKeyboardHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_keyboard_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getKeyboardHandler() {
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

func CEFClient_getRenderHandler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_render_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getRenderHandler() {
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

