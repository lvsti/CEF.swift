//
//  CEFPrintSettings+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_print_settings.h.
//

import Foundation

extension cef_print_settings_t: CEFObject {}

/// Class representing print settings.
public class CEFPrintSettings: CEFProxy<cef_print_settings_t> {
    override init?(ptr: UnsafeMutablePointer<cef_print_settings_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_print_settings_t>) -> CEFPrintSettings? {
        return CEFPrintSettings(ptr: ptr)
    }
}

