//
//  CEFValueType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFValueType: Int {
    case Invalid = 0
    case Null
    case Bool
    case Int
    case Double
    case String
    case Binary
    case Dictionary
    case List
}

