//
//  CEFSize.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension NSSize {
    func toCEF() -> cef_size_t {
        return cef_size_t(width: Int32(self.width), height: Int32(self.height))
    }
    
    static func fromCEF(value: cef_size_t) -> NSSize {
        return NSSize(width: Int(value.width), height: Int(value.height))
    }
}

