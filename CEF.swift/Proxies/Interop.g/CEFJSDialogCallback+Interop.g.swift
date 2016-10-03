//
//  CEFJSDialogCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_jsdialog_handler.h.
//

import Foundation

extension cef_jsdialog_callback_t: CEFObject {}

/// Callback interface used for asynchronous continuation of JavaScript dialog
/// requests.
public class CEFJSDialogCallback: CEFProxy<cef_jsdialog_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_jsdialog_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_jsdialog_callback_t>?) -> CEFJSDialogCallback? {
        return CEFJSDialogCallback(ptr: ptr)
    }
}

