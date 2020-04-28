//
//  CEFMediaObserver.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implemented by the client to observe MediaRouter events and registered via
/// CefMediaRouter::AddObserver. The methods of this class will be called on the
/// browser process UI thread.
public protocol CEFMediaObserver {
    
    /// The list of available media sinks has changed or
    /// CefMediaRouter::NotifyCurrentSinks was called.
    /// CEF name: `OnSinks`
    func onSinks(_ sinks: [CEFMediaSink])
    
    /// The list of available media routes has changed or
    /// CefMediaRouter::NotifyCurrentRoutes was called.
    /// CEF name: `OnRoutes`
    func onRoutes(_ routes: [CEFMediaRoute])
    
    /// The connection state of |route| has changed.
    /// CEF name: `OnRouteStateChanged`
    func onRouteStateChanged(route: CEFMediaRoute, state: CEFMediaRouteConnectionState)
    
    /// A message was recieved over |route|. |message| is only valid for
    /// the scope of this callback and should be copied if necessary.
    /// CEF name: `OnRouteMessageReceived`
    func onRouteMessageReceived(route: CEFMediaRoute, messageData: Data)
}

public extension CEFMediaObserver {
    
    func onSinks(_ sinks: [CEFMediaSink]) {
    }
    
    func onRoutes(_ routes: [CEFMediaRoute]) {
    }
    
    func onRouteStateChanged(route: CEFMediaRoute, state: CEFMediaRouteConnectionState) {
    }
    
    func onRouteMessageReceived(route: CEFMediaRoute, messageData: Data) {
    }

}
