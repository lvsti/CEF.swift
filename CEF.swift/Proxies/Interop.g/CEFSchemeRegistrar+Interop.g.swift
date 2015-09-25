//
//  CEFSchemeRegistrar+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_scheme.h.
//

import Foundation

extension cef_scheme_registrar_t: CEFObject {}

/// Class that manages custom scheme registrations.
public class CEFSchemeRegistrar: CEFProxy<cef_scheme_registrar_t> {
    override init?(ptr: UnsafeMutablePointer<cef_scheme_registrar_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_scheme_registrar_t>) -> CEFSchemeRegistrar? {
        return CEFSchemeRegistrar(ptr: ptr)
    }
}

