//
//  JSDialogHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_jsdialog_handler.h.
//

import Foundation

extension cef_jsdialog_handler_t: CEFObject {}

typealias JSDialogHandlerMarshaller = Marshaller<JSDialogHandler, cef_jsdialog_handler_t>

extension JSDialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_jsdialog_handler_t> {
        return JSDialogHandlerMarshaller.pass(self)
    }
}

extension cef_jsdialog_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_jsdialog = JSDialogHandler_on_jsdialog
        on_before_unload_dialog = JSDialogHandler_on_before_unload_dialog
        on_reset_dialog_state = JSDialogHandler_on_reset_dialog_state
        on_dialog_closed = JSDialogHandler_on_dialog_closed
    }
}
