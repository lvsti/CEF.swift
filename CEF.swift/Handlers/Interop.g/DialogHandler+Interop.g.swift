//
//  DialogHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dialog_handler.h.
//

import Foundation

extension cef_dialog_handler_t: CEFObject {}

typealias DialogHandlerMarshaller = Marshaller<DialogHandler, cef_dialog_handler_t>

extension DialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_dialog_handler_t> {
        return DialogHandlerMarshaller.pass(self)
    }
}

extension cef_dialog_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_file_dialog = DialogHandler_on_file_dialog
    }
}
