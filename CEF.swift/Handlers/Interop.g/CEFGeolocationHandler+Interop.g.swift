//
//  CEFGeolocationHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_geolocation_handler.h.
//

import Foundation

extension cef_geolocation_handler_t: CEFObject {}

typealias CEFGeolocationHandlerMarshaller = CEFMarshaller<CEFGeolocationHandler, cef_geolocation_handler_t>

extension CEFGeolocationHandler {
    func toCEF() -> UnsafeMutablePointer<cef_geolocation_handler_t> {
        return CEFGeolocationHandlerMarshaller.pass(self)
    }
}

extension cef_geolocation_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_geolocation_permission = CEFGeolocationHandler_on_request_geolocation_permission
        on_cancel_geolocation_permission = CEFGeolocationHandler_on_cancel_geolocation_permission
    }
}
