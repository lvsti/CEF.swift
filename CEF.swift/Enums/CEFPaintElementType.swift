//
//  CEFPaintElementType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFPaintElementType: Int {
    case View = 0
    case Popup
}

extension CEFPaintElementType {
    func toCEF() -> cef_paint_element_type_t {
        return cef_paint_element_type_t(rawValue: UInt32(rawValue))
    }
}

