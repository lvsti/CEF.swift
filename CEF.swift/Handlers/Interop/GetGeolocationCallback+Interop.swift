//
//  GetGeolocationCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func GetGeolocationCallback_on_location_update(ptr: UnsafeMutablePointer<cef_get_geolocation_callback_t>,
                                               position: UnsafePointer<cef_geoposition_t>) {
    guard let obj = GetGeolocationCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onLocationUpdate(Geoposition.fromCEF(position.memory))
}
