//
//  CEFV8ContextSafetyImplementation.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFV8ContextSafetyImplementation: Int {
    case defaultImplementation = 0
    case alternate = 1
    case disabled = -1
}

extension CEFV8ContextSafetyImplementation {
    func toCEF() -> Int32 {
        return Int32(rawValue)
    }
}
