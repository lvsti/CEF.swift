//
//  Client+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_client.h.
//

import Foundation

extension cef_client_t: CEFObject {}

typealias ClientMarshaller = Marshaller<Client, cef_client_t>

extension Client {
    func toCEF() -> UnsafeMutablePointer<cef_client_t> {
        return ClientMarshaller.pass(self)
    }
}

extension cef_client_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        get_context_menu_handler = Client_get_context_menu_handler
        get_dialog_handler = Client_get_dialog_handler
        get_display_handler = Client_get_display_handler
        get_download_handler = Client_get_download_handler
        get_drag_handler = Client_get_drag_handler
        get_find_handler = Client_get_find_handler
        get_focus_handler = Client_get_focus_handler
        get_geolocation_handler = Client_get_geolocation_handler
        get_jsdialog_handler = Client_get_jsdialog_handler
        get_keyboard_handler = Client_get_keyboard_handler
        get_life_span_handler = Client_get_life_span_handler
        get_load_handler = Client_get_load_handler
        get_render_handler = Client_get_render_handler
        get_request_handler = Client_get_request_handler
        on_process_message_received = Client_on_process_message_received
    }
}
