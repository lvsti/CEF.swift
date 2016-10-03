//
//  CEFDictionaryValue+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_values.h.
//

import Foundation

extension cef_dictionary_value_t: CEFObject {}

/// Class representing a dictionary value. Can be used on any process and thread.
public class CEFDictionaryValue: CEFProxy<cef_dictionary_value_t> {
    override init?(ptr: UnsafeMutablePointer<cef_dictionary_value_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_dictionary_value_t>?) -> CEFDictionaryValue? {
        return CEFDictionaryValue(ptr: ptr)
    }
}

