//
//  CEFExtension+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_extension.h.
//

import Foundation

extension cef_extension_t: CEFObject {}

/// Object representing an extension. Methods may be called on any thread unless
/// otherwise indicated.
/// CEF name: `CefExtension`
public class CEFExtension: CEFProxy<cef_extension_t> {
    override init?(ptr: UnsafeMutablePointer<cef_extension_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_extension_t>?) -> CEFExtension? {
        return CEFExtension(ptr: ptr)
    }
}

