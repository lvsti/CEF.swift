//
//  ContextMenuHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_context_menu_handler.h.
//

import Foundation

extension cef_context_menu_handler_t: CEFObject {}

typealias ContextMenuHandlerMarshaller = Marshaller<ContextMenuHandler, cef_context_menu_handler_t>

extension ContextMenuHandler {
    func toCEF() -> UnsafeMutablePointer<cef_context_menu_handler_t> {
        return ContextMenuHandlerMarshaller.pass(self)
    }
}

extension cef_context_menu_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_context_menu = ContextMenuHandler_on_before_context_menu
        on_context_menu_command = ContextMenuHandler_on_context_menu_command
        on_context_menu_dismissed = ContextMenuHandler_on_context_menu_dismissed
    }
}
