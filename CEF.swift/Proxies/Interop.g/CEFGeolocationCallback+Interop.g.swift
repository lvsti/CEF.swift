//
//  CEFGeolocationCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_geolocation_handler.h.
//

import Foundation

extension cef_geolocation_callback_t: CEFObject {}

/// Callback interface used for asynchronous continuation of geolocation
/// permission requests.
public class CEFGeolocationCallback: CEFProxy<cef_geolocation_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_geolocation_callback_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_geolocation_callback_t>) -> CEFGeolocationCallback? {
        return CEFGeolocationCallback(ptr: ptr)
    }
}

