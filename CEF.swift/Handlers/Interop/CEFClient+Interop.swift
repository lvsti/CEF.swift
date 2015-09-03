//
//  CEFClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFClient_get_context_menu_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_context_menu_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.contextMenuHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_display_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_display_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.displayHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_dialog_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_dialog_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.dialogHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_download_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_download_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.downloadHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_drag_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_drag_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.dragHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_find_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_find_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.findHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_focus_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_focus_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.focusHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_geolocation_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_geolocation_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.geolocationHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_jsdialog_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_jsdialog_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.jsDialogHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_keyboard_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_keyboard_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.keyboardHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_life_span_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_life_span_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.lifeSpanHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_load_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_load_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.loadHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_render_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_render_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.renderHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_get_request_handler(ptr: UnsafeMutablePointer<cef_client_t>) -> UnsafeMutablePointer<cef_request_handler_t> {
    guard let obj = CEFClientMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.requestHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFClient_on_process_message_received(ptr: UnsafeMutablePointer<cef_client_t>,
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

