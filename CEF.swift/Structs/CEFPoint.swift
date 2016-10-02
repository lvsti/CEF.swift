//
//  CEFPoint.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension NSPoint {
    func toCEF() -> cef_point_t {
        return cef_point_t(x: Int32(self.x), y: Int32(self.y))
    }
    
    static func fromCEF(_ value: cef_point_t) -> NSPoint {
        return NSPoint(x: Int(value.x), y: Int(value.y))
    }
}

