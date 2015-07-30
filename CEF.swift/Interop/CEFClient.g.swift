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

typealias CEFClientMarshaller = CEFMarshaller<CEFClient>

extension CEFClient: CEFMarshallable {
    typealias StructType = cef_client_t

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

