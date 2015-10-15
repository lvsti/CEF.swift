//
//  CEFContextMenuHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_context_menu_handler.h.
//

import Foundation

extension cef_context_menu_handler_t: CEFObject {}

typealias CEFContextMenuHandlerMarshaller = CEFMarshaller<CEFContextMenuHandler, cef_context_menu_handler_t>

extension CEFContextMenuHandler {
    func toCEF() -> UnsafeMutablePointer<cef_context_menu_handler_t> {
        return CEFContextMenuHandlerMarshaller.pass(self)
    }
}

extension cef_context_menu_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_context_menu = CEFContextMenuHandler_on_before_context_menu
        run_context_menu = CEFContextMenuHandler_run_context_menu
        on_context_menu_command = CEFContextMenuHandler_on_context_menu_command
        on_context_menu_dismissed = CEFContextMenuHandler_on_context_menu_dismissed
    }
}
