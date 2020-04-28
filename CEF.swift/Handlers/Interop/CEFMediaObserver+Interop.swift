//
//  CEFMediaObserver+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFMediaObserver_on_sinks(ptr: UnsafeMutablePointer<cef_media_observer_t>?,
                               count: Int,
                               sinks: UnsafePointer<UnsafeMutablePointer<cef_media_sink_t>?>?) {
    guard let obj = CEFMediaObserverMarshaller.get(ptr) else {
        return
    }
 
    let buffer = UnsafeBufferPointer<UnsafeMutablePointer<cef_media_sink_t>?>(start: sinks, count: count)
    obj.onSinks(buffer.map { CEFMediaSink.fromCEF($0)! })
}

func CEFMediaObserver_on_routes(ptr: UnsafeMutablePointer<cef_media_observer_t>?,
                                count: Int,
                                routes: UnsafePointer<UnsafeMutablePointer<cef_media_route_t>?>?) {
    guard let obj = CEFMediaObserverMarshaller.get(ptr) else {
        return
    }

    let buffer = UnsafeBufferPointer<UnsafeMutablePointer<cef_media_route_t>?>(start: routes, count: count)
    obj.onRoutes(buffer.map { CEFMediaRoute.fromCEF($0)! })
}

func CEFMediaObserver_on_route_state_changed(ptr: UnsafeMutablePointer<cef_media_observer_t>?,
                                             route: UnsafeMutablePointer<cef_media_route_t>?,
                                             state: cef_media_route_connection_state_t) {
    guard let obj = CEFMediaObserverMarshaller.get(ptr) else {
        return
    }
    
    obj.onRouteStateChanged(route: CEFMediaRoute.fromCEF(route)!,
                            state: CEFMediaRouteConnectionState.fromCEF(state))
}

func CEFMediaObserver_on_route_message_received(ptr: UnsafeMutablePointer<cef_media_observer_t>?,
                                                route: UnsafeMutablePointer<cef_media_route_t>?,
                                                msg: UnsafeRawPointer?,
                                                size: size_t) {
    guard let obj = CEFMediaObserverMarshaller.get(ptr) else {
        return
    }
    
    let data = Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: msg!),
                    count: size,
                    deallocator: .none)
    obj.onRouteMessageReceived(route: CEFMediaRoute.fromCEF(route)!,
                               messageData: data)
}
