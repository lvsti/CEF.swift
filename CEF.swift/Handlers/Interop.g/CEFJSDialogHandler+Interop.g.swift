//
//  CEFJSDialogHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_jsdialog_handler.h.
//

import Foundation

extension cef_jsdialog_handler_t: CEFObject {}

typealias CEFJSDialogHandlerMarshaller = CEFMarshaller<CEFJSDialogHandler, cef_jsdialog_handler_t>

extension CEFJSDialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_jsdialog_handler_t> {
        return CEFJSDialogHandlerMarshaller.pass(self)
    }
}

extension cef_jsdialog_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_jsdialog = CEFJSDialogHandler_on_jsdialog
        on_before_unload_dialog = CEFJSDialogHandler_on_before_unload_dialog
        on_reset_dialog_state = CEFJSDialogHandler_on_reset_dialog_state
        on_dialog_closed = CEFJSDialogHandler_on_dialog_closed
    }
}
