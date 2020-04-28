//
//  CEFMediaObserver+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_observer_t: CEFObject {}

typealias CEFMediaObserverMarshaller = CEFMarshaller<CEFMediaObserver, cef_media_observer_t>

extension CEFMediaObserver {
    func toCEF() -> UnsafeMutablePointer<cef_media_observer_t> {
        return CEFMediaObserverMarshaller.pass(self)
    }
}

extension cef_media_observer_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_sinks = CEFMediaObserver_on_sinks
        on_routes = CEFMediaObserver_on_routes
        on_route_state_changed = CEFMediaObserver_on_route_state_changed
        on_route_message_received = CEFMediaObserver_on_route_message_received
    }
}
