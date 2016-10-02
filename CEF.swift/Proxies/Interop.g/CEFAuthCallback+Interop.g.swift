//
//  CEFAuthCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_auth_callback.h.
//

import Foundation

extension cef_auth_callback_t: CEFObject {}

/// Callback interface used for asynchronous continuation of authentication
/// requests.
public class CEFAuthCallback: CEFProxy<cef_auth_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_auth_callback_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_auth_callback_t>) -> CEFAuthCallback? {
        return CEFAuthCallback(ptr: ptr)
    }
}

