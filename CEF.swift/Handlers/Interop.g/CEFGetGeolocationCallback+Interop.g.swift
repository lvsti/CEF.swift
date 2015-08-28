//
//  CEFGetGeolocationCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_geolocation.h.
//

import Foundation

extension cef_get_geolocation_callback_t: CEFObject {}

typealias CEFGetGeolocationCallbackMarshaller = CEFMarshaller<CEFGetGeolocationCallback, cef_get_geolocation_callback_t>

extension cef_get_geolocation_callback_t {
    func toCEF() -> UnsafeMutablePointer<cef_get_geolocation_callback_t> {
        return CEFGetGeolocationCallbackMarshaller.pass(self)
    }
}

extension cef_get_geolocation_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_location_update = CEFGetGeolocationCallback_on_location_update
    }
}
