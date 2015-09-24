//
//  DisplayHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_display_handler.h.
//

import Foundation

extension cef_display_handler_t: CEFObject {}

typealias DisplayHandlerMarshaller = Marshaller<DisplayHandler, cef_display_handler_t>

extension DisplayHandler {
    func toCEF() -> UnsafeMutablePointer<cef_display_handler_t> {
        return DisplayHandlerMarshaller.pass(self)
    }
}

extension cef_display_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_address_change = DisplayHandler_on_address_change
        on_title_change = DisplayHandler_on_title_change
        on_favicon_urlchange = DisplayHandler_on_favicon_urlchange
        on_tooltip = DisplayHandler_on_tooltip
        on_status_message = DisplayHandler_on_status_message
        on_console_message = DisplayHandler_on_console_message
    }
}
