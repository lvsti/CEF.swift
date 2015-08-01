//
//  CEFV8PropertyAttribute.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFV8PropertyAttribute: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let None = CEFV8PropertyAttribute(rawValue: 0)
    public static let ReadOnly = CEFV8PropertyAttribute(rawValue: 1 << 0)
    public static let DontEnum = CEFV8PropertyAttribute(rawValue: 1 << 1)
    public static let DontDelete = CEFV8PropertyAttribute(rawValue: 1 << 2)
}

extension CEFV8PropertyAttribute {
    func toCEF() -> cef_v8_propertyattribute_t {
        return cef_v8_propertyattribute_t(rawValue: UInt32(rawValue))
    }
}

