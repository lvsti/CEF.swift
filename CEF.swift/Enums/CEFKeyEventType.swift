//
//  CEFKeyEventType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFKeyEventType: Int {
    case RawKeyDown = 0
    case KeyDown
    case KeyUp
    case Char
}

extension CEFKeyEventType {
    func toCEF() -> cef_key_event_type_t {
        return cef_key_event_type_t(rawValue: UInt32(rawValue))
    }
}

