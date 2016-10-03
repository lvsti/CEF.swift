//
//  CEFBinaryValue+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_values.h.
//

import Foundation

extension cef_binary_value_t: CEFObject {}

/// Class representing a binary value. Can be used on any process and thread.
public class CEFBinaryValue: CEFProxy<cef_binary_value_t> {
    override init?(ptr: UnsafeMutablePointer<cef_binary_value_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_binary_value_t>?) -> CEFBinaryValue? {
        return CEFBinaryValue(ptr: ptr)
    }
}

