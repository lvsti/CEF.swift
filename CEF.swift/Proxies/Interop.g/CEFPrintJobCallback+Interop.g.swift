//
//  CEFPrintJobCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_print_handler.h.
//

import Foundation

extension cef_print_job_callback_t: CEFObject {}

/// Callback interface for asynchronous continuation of print job requests.
public class CEFPrintJobCallback: CEFProxy<cef_print_job_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_print_job_callback_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_print_job_callback_t>) -> CEFPrintJobCallback? {
        return CEFPrintJobCallback(ptr: ptr)
    }
}

