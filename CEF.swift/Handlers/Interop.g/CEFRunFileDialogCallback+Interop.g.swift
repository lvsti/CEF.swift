//
//  CEFRunFileDialogCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_run_file_dialog_callback_t: CEFObject {}

typealias CEFRunFileDialogCallbackMarshaller = CEFMarshaller<CEFRunFileDialogCallback, cef_run_file_dialog_callback_t>

extension cef_run_file_dialog_callback_t {
    func toCEF() -> UnsafeMutablePointer<cef_run_file_dialog_callback_t> {
        return CEFRunFileDialogCallbackMarshaller.pass(self)
    }
}

extension cef_run_file_dialog_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_file_dialog_dismissed = CEFRunFileDialogCallback_on_file_dialog_dismissed
    }
}
