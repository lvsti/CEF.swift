//
//  GetGeolocationCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive geolocation updates. The methods of this
/// class will be called on the browser process UI thread.
public protocol GetGeolocationCallback {
    
    /// Called with the 'best available' location information or, if the location
    /// update failed, with error information.
    func onLocationUpdate(position: Geoposition)

}

public extension GetGeolocationCallback {

    func onLocationUpdate(position: Geoposition) {
    }

}

