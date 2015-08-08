//
//  CEFGetGeolocationCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_get_geolocation_callback_t: CEFObject {
}

typealias CEFGetGeolocationCallbackMarshaller = CEFMarshaller<CEFGetGeolocationCallback, cef_get_geolocation_callback_t>

extension CEFGetGeolocationCallback {
    func toCEF() -> UnsafeMutablePointer<cef_get_geolocation_callback_t> {
        return CEFGetGeolocationCallbackMarshaller.pass(self)
    }
}

extension cef_get_geolocation_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_location_update = CEFGetGeolocationCallback_onLocationUpdate
    }
}

func CEFGetGeolocationCallback_onLocationUpdate(ptr: UnsafeMutablePointer<cef_get_geolocation_callback_t>,
                                                position: UnsafePointer<cef_geoposition_t>) {
    guard let obj = CEFGetGeolocationCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onLocationUpdate(CEFGeoposition.fromCEF(position.memory))
}
