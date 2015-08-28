//
//  CEFPrintHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_print_handler.h.
//

import Foundation

extension cef_print_handler_t: CEFObject {}

typealias CEFPrintHandlerMarshaller = CEFMarshaller<CEFPrintHandler, cef_print_handler_t>

extension CEFPrintHandler {
    func toCEF() -> UnsafeMutablePointer<cef_print_handler_t> {
        return CEFPrintHandlerMarshaller.pass(self)
    }
}

extension cef_print_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_print_settings = CEFPrintHandler_on_print_settings
        on_print_dialog = CEFPrintHandler_on_print_dialog
        on_print_job = CEFPrintHandler_on_print_job
        on_print_reset = CEFPrintHandler_on_print_reset
    }
}
