//
//  CEFFileDialogCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dialog_handler.h.
//

import Foundation

extension cef_file_dialog_callback_t: CEFObject {}

/// Callback interface for asynchronous continuation of file dialog requests.
public class CEFFileDialogCallback: CEFProxy<cef_file_dialog_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_file_dialog_callback_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_file_dialog_callback_t>) -> CEFFileDialogCallback? {
        return CEFFileDialogCallback(ptr: ptr)
    }
}

