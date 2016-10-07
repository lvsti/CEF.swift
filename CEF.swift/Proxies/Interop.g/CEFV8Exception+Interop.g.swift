//
//  CEFV8Exception+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8exception_t: CEFObject {}

/// Class representing a V8 exception. The methods of this class may be called on
/// any render process thread.
/// CEF name: `CefV8Exception`
public class CEFV8Exception: CEFProxy<cef_v8exception_t> {
    override init?(ptr: UnsafeMutablePointer<cef_v8exception_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_v8exception_t>?) -> CEFV8Exception? {
        return CEFV8Exception(ptr: ptr)
    }
}

