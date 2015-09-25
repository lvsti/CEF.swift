//
//  CEFCookieManager+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_cookie.h.
//

import Foundation

extension cef_cookie_manager_t: CEFObject {}

/// Class used for managing cookies. The methods of this class may be called on
/// any thread unless otherwise indicated.
public class CEFCookieManager: CEFProxy<cef_cookie_manager_t> {
    override init?(ptr: UnsafeMutablePointer<cef_cookie_manager_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_cookie_manager_t>) -> CEFCookieManager? {
        return CEFCookieManager(ptr: ptr)
    }
}

