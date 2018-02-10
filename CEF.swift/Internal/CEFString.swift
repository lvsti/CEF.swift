//
//  CEFString.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringToSwiftString(_ cefStr: cef_string_t) -> String {
    guard cefStr.str != nil else {
        return ""
    }
    return String(NSString(characters: cefStr.str, length: cefStr.length))
}

func CEFStringPtrToSwiftString(_ ptr: UnsafePointer<cef_string_t>?, defaultValue: String) -> String {
    guard let str = ptr?.pointee else {
        return defaultValue
    }
    return CEFStringToSwiftString(str)
}

func CEFStringPtrToSwiftString(_ ptr: UnsafePointer<cef_string_t>?) -> String? {
    guard let cefStr = ptr?.pointee else {
        return nil
    }
    return CEFStringToSwiftString(cefStr)
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
