//
//  GetGeolocationCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Called with the 'best available' location information or, if the location
/// update failed, with error information.
public typealias GetGeolocationCallbackOnLocationUpdateBlock = (position: Geoposition) -> Void

class GetGeolocationCallbackBridge: GetGeolocationCallback {
    let block: GetGeolocationCallbackOnLocationUpdateBlock
    
    init(block: GetGeolocationCallbackOnLocationUpdateBlock) {
        self.block = block
    }
    
    func onLocationUpdate(position: Geoposition) {
        block(position: position)
    }
}
