//
//  CEFListValue+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_values.h.
//

import Foundation

extension cef_list_value_t: CEFObject {}

/// Class representing a list value. Can be used on any process and thread.
public class CEFListValue: CEFProxy<cef_list_value_t> {
    override init?(ptr: UnsafeMutablePointer<cef_list_value_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_list_value_t>) -> CEFListValue? {
        return CEFListValue(ptr: ptr)
    }
}

