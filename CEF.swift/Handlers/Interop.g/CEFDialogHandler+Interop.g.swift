//
//  CEFDialogHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dialog_handler.h.
//

import Foundation

extension cef_dialog_handler_t: CEFObject {}

typealias CEFDialogHandlerMarshaller = CEFMarshaller<CEFDialogHandler, cef_dialog_handler_t>

extension CEFDialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_dialog_handler_t> {
        return CEFDialogHandlerMarshaller.pass(self)
    }
}

extension cef_dialog_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_file_dialog = CEFDialogHandler_on_file_dialog
    }
}
