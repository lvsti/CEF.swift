//
//  GetGeolocationCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_geolocation.h.
//

import Foundation

extension cef_get_geolocation_callback_t: CEFObject {}

typealias GetGeolocationCallbackMarshaller = Marshaller<GetGeolocationCallback, cef_get_geolocation_callback_t>

extension GetGeolocationCallback {
    func toCEF() -> UnsafeMutablePointer<cef_get_geolocation_callback_t> {
        return GetGeolocationCallbackMarshaller.pass(self)
    }
}

extension cef_get_geolocation_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_location_update = GetGeolocationCallback_on_location_update
    }
}
