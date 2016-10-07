//
//  CEFGetGeolocationCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive geolocation updates. The methods of this
/// class will be called on the browser process UI thread.
/// CEF name: `CefGetGeolocationCallback`
public protocol CEFGetGeolocationCallback {
    
    /// Called with the 'best available' location information or, if the location
    /// update failed, with error information.
    /// CEF name: `OnLocationUpdate`
    func onLocationUpdate(position: CEFGeoposition)

}

public extension CEFGetGeolocationCallback {

    func onLocationUpdate(position: CEFGeoposition) {
    }

}

