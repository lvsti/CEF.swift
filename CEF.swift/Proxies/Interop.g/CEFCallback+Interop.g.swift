//
//  CEFCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_callback.h.
//

import Foundation

extension cef_callback_t: CEFObject {}

/// Generic callback interface used for asynchronous continuation.
public class CEFCallback: CEFProxy<cef_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_callback_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_callback_t>) -> CEFCallback? {
        return CEFCallback(ptr: ptr)
    }
}

