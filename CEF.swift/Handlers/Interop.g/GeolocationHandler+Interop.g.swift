//
//  GeolocationHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_geolocation_handler.h.
//

import Foundation

extension cef_geolocation_handler_t: CEFObject {}

typealias GeolocationHandlerMarshaller = Marshaller<GeolocationHandler, cef_geolocation_handler_t>

extension GeolocationHandler {
    func toCEF() -> UnsafeMutablePointer<cef_geolocation_handler_t> {
        return GeolocationHandlerMarshaller.pass(self)
    }
}

extension cef_geolocation_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_geolocation_permission = GeolocationHandler_on_request_geolocation_permission
        on_cancel_geolocation_permission = GeolocationHandler_on_cancel_geolocation_permission
    }
}
