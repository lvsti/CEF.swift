//
//  CEFMouseButtonType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFMouseButtonType: Int {
    case Left = 0
    case Middle
    case Right
}

extension CEFMouseButtonType {
    func toCEF() -> cef_mouse_button_type_t {
        return cef_mouse_button_type_t(rawValue: UInt32(rawValue))
    }
}


