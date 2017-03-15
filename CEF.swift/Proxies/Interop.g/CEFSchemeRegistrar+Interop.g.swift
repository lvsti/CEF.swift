//
//  CEFSchemeRegistrar+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_scheme.h.
//

import Foundation

extension cef_scheme_registrar_t: CEFScopedObject {}

/// Class that manages custom scheme registrations.
/// CEF name: `CefSchemeRegistrar`
public class CEFSchemeRegistrar: CEFScopedProxy<cef_scheme_registrar_t> {
    override init?(ptr: UnsafeMutablePointer<cef_scheme_registrar_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_scheme_registrar_t>?) -> CEFSchemeRegistrar? {
        return CEFSchemeRegistrar(ptr: ptr)
    }
}

