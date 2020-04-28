//
//  CEFRegistration+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_registration.h.
//

import Foundation

extension cef_registration_t: CEFObject {}

/// Generic callback interface used for managing the lifespan of a registration.
/// CEF name: `CefRegistration`
public final class CEFRegistration: CEFProxy<cef_registration_t> {
    override init?(ptr: UnsafeMutablePointer<cef_registration_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_registration_t>?) -> CEFRegistration? {
        return CEFRegistration(ptr: ptr)
    }
}

