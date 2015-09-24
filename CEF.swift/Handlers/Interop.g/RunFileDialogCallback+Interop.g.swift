//
//  RunFileDialogCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_run_file_dialog_callback_t: CEFObject {}

typealias RunFileDialogCallbackMarshaller = Marshaller<RunFileDialogCallback, cef_run_file_dialog_callback_t>

extension RunFileDialogCallback {
    func toCEF() -> UnsafeMutablePointer<cef_run_file_dialog_callback_t> {
        return RunFileDialogCallbackMarshaller.pass(self)
    }
}

extension cef_run_file_dialog_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_file_dialog_dismissed = RunFileDialogCallback_on_file_dialog_dismissed
    }
}
