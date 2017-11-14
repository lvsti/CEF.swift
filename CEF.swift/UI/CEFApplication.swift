//
//  CEFApplication.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 07..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Cocoa

// from include/cef_application_mac.h

/// Copy of definition from base/message_loop/message_pump_mac.h.
@objc protocol CrAppProtocol {
    /// Must return true if -[NSApplication sendEvent:] is currently on the stack.
    func isHandlingSendEvent() -> Bool
}

/// Copy of definition from base/mac/scoped_sending_event.h.
@objc protocol CrAppControlProtocol: CrAppProtocol {
    func setHandlingSendEvent(_ handlingSendEvent: Bool)
}

/// All CEF client applications must subclass NSApplication and implement this
/// protocol.
@objc protocol CefAppProtocol: CrAppControlProtocol {
}


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
