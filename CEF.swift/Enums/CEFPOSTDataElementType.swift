//
//  CEFPOSTDataElementType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFPOSTDataElementType: Int {
    case Empty = 0
    case Bytes
    case File
}

extension CEFPOSTDataElementType {
    static func fromCEF(value: cef_postdataelement_type_t) -> CEFPOSTDataElementType {
        return CEFPOSTDataElementType(rawValue: Int(value.rawValue))!
    }
}

