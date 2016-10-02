//
//  CEFValue+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_values.h.
//

import Foundation

extension cef_value_t: CEFObject {}

/// Class that wraps other data value types. Complex types (binary, dictionary
/// and list) will be referenced but not owned by this object. Can be used on any
/// process and thread.
public class CEFValue: CEFProxy<cef_value_t> {
    override init?(ptr: UnsafeMutablePointer<cef_value_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_value_t>) -> CEFValue? {
        return CEFValue(ptr: ptr)
    }
}

