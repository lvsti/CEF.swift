//
//  CEFString.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringToSwiftString(_ cefStr: cef_string_t) -> String {
    return String(NSString(characters: cefStr.str, length: cefStr.length))
}

func CEFStringPtrCreateFromSwiftString(_ str: String) -> cef_string_userfree_utf16_t {
    let cefStr = cef_string_userfree_utf16_alloc()!
    CEFStringSetFromSwiftString(str, cefStringPtr: cefStr)
    return cefStr
}

func CEFStringPtrRelease(_ ptr: cef_string_userfree_utf16_t?) {
    if let ptr = ptr {
        cef_string_userfree_utf16_free(ptr)
    }
}

func CEFStringSetFromSwiftString(_ str: String, cefStringPtr ptr: UnsafeMutablePointer<cef_string_t>) {
    Array(str.utf16).withUnsafeBufferPointer { (buffer: UnsafeBufferPointer<UTF16.CodeUnit>) -> Void in
        cef_string_utf16_set(buffer.baseAddress, buffer.count, ptr, 1)
    }
}
