//
//  CEFMediaRouteCreateCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_route_create_callback_t: CEFObject {}

typealias CEFMediaRouteCreateCallbackMarshaller = CEFMarshaller<CEFMediaRouteCreateCallback, cef_media_route_create_callback_t>

extension CEFMediaRouteCreateCallback {
    func toCEF() -> UnsafeMutablePointer<cef_media_route_create_callback_t> {
        return CEFMediaRouteCreateCallbackMarshaller.pass(self)
    }
}

extension cef_media_route_create_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_media_route_create_finished = CEFMediaRouteCreateCallback_on_media_route_create_finished
    }
}
