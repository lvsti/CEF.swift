//
//  CEFClient+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_client.h.
//

import Foundation

extension cef_client_t: CEFObject {}

typealias CEFClientMarshaller = CEFMarshaller<CEFClient, cef_client_t>

extension CEFClient {
    func toCEF() -> UnsafeMutablePointer<cef_client_t> {
        return CEFClientMarshaller.pass(self)
    }
}

extension cef_client_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_context_menu_handler = CEFClient_get_context_menu_handler
        get_dialog_handler = CEFClient_get_dialog_handler
        get_display_handler = CEFClient_get_display_handler
        get_download_handler = CEFClient_get_download_handler
        get_drag_handler = CEFClient_get_drag_handler
        get_find_handler = CEFClient_get_find_handler
        get_focus_handler = CEFClient_get_focus_handler
        get_geolocation_handler = CEFClient_get_geolocation_handler
        get_jsdialog_handler = CEFClient_get_jsdialog_handler
        get_keyboard_handler = CEFClient_get_keyboard_handler
        get_life_span_handler = CEFClient_get_life_span_handler
        get_load_handler = CEFClient_get_load_handler
        get_render_handler = CEFClient_get_render_handler
        get_request_handler = CEFClient_get_request_handler
        on_process_message_received = CEFClient_on_process_message_received
    }
}
