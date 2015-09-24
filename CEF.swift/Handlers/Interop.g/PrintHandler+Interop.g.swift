//
//  PrintHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_print_handler.h.
//

import Foundation

extension cef_print_handler_t: CEFObject {}

typealias PrintHandlerMarshaller = Marshaller<PrintHandler, cef_print_handler_t>

extension PrintHandler {
    func toCEF() -> UnsafeMutablePointer<cef_print_handler_t> {
        return PrintHandlerMarshaller.pass(self)
    }
}

extension cef_print_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_print_settings = PrintHandler_on_print_settings
        on_print_dialog = PrintHandler_on_print_dialog
        on_print_job = PrintHandler_on_print_job
        on_print_reset = PrintHandler_on_print_reset
    }
}
