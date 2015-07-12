//
//  CEFString.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringToSwiftString(cefStr: cef_string_t) -> String {
    return String(NSString(characters: cefStr.str, length: cefStr.length))
}

func CEFStringPtrFromSwiftString(str: String) -> cef_string_userfree_t {
    let cefStr = cef_string_userfree_utf16_alloc()
    Array(str.utf16).withUnsafeBufferPointer { (buffer: UnsafeBufferPointer<UTF16.CodeUnit>) -> Void in
        cef_string_utf16_set(buffer.baseAddress, buffer.count, cefStr, 1)
    }
    
    return cefStr
}

