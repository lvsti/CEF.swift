//
//  CEFRect.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension NSRect {
    func toCEF() -> cef_rect_t {
        return cef_rect_t(x: Int32(self.origin.x),
                          y: Int32(self.origin.y),
                          width: Int32(self.size.width),
                          height: Int32(self.size.height))
    }
    
    static func fromCEF(value: cef_rect_t) -> NSRect {
        return NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height))
    }
}

