//
//  CEFApplication.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 07..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Cocoa

/// All CEF client applications must subclass CEFApplication to work properly.
open class CEFApplication: NSApplication {

    fileprivate var _isHandlingSendEvent: Bool = false
    
    open override func sendEvent(_ event: NSEvent) {
        let stashedIsHandlingSendEvent = _isHandlingSendEvent
        _isHandlingSendEvent = true
        defer { _isHandlingSendEvent = stashedIsHandlingSendEvent }
        
        super.sendEvent(event)
    }

}

extension CEFApplication: CefAppProtocol {

    public func isHandlingSendEvent() -> Bool {
        return _isHandlingSendEvent
    }
    
    public func setHandlingSendEvent(_ handlingSendEvent: Bool) {
        _isHandlingSendEvent = handlingSendEvent
    }
    
}
