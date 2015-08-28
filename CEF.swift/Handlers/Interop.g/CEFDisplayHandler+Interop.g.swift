//
//  CEFDisplayHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_display_handler.h.
//

import Foundation

extension cef_display_handler_t: CEFObject {}

typealias CEFDisplayHandlerMarshaller = CEFMarshaller<CEFDisplayHandler, cef_display_handler_t>

extension cef_display_handler_t {
    func toCEF() -> UnsafeMutablePointer<cef_display_handler_t> {
        return CEFDisplayHandlerMarshaller.pass(self)
    }
}

extension cef_display_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_address_change = CEFDisplayHandler_on_address_change
        on_title_change = CEFDisplayHandler_on_title_change
        on_favicon_urlchange = CEFDisplayHandler_on_favicon_urlchange
        on_tooltip = CEFDisplayHandler_on_tooltip
        on_status_message = CEFDisplayHandler_on_status_message
        on_console_message = CEFDisplayHandler_on_console_message
    }
}
