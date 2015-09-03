//
//  CEFGetGeolocationCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFGetGeolocationCallbackOnLocationUpdateBlock = (position: CEFGeoposition) -> Void

class CEFGetGeolocationCallbackBridge: CEFGetGeolocationCallback {
    let block: CEFGetGeolocationCallbackOnLocationUpdateBlock
    
    init(block: CEFGetGeolocationCallbackOnLocationUpdateBlock) {
        self.block = block
    }
    
    func onLocationUpdate(position: CEFGeoposition) {
        block(position: position)
    }
}
