//
//  CEFMediaRouteCreateCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefMediaRouter::CreateRoute. The methods of this
/// class will be called on the browser process UI thread.
public protocol CEFMediaRouteCreateCallback {
    
    /// Method that will be executed when the route creation has finished. |result|
    /// will be CEF_MRCR_OK if the route creation succeeded. |error| will be a
    /// description of the error if the route creation failed. |route| is the
    /// resulting route, or empty if the route creation failed.
    /// CEF name: `OnMediaRouteCreateFinished`
    func onMediaRouteCreateFinished(result: CEFMediaRouteCreateResult,
                                    error: String?,
                                    route: CEFMediaRoute?)

}


public extension CEFMediaRouteCreateCallback {
    
    func onMediaRouteCreateFinished(result: CEFMediaRouteCreateResult,
                                    error: String?,
                                    route: CEFMediaRoute?) {
    }

}

