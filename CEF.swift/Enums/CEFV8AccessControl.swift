//
//  CEFV8AccessControl.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFV8AccessControl: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let Default = CEFV8AccessControl(rawValue: 0)
    public static let AllCanRead = CEFV8AccessControl(rawValue: 1 << 0)
    public static let AllCanWrite = CEFV8AccessControl(rawValue: 1 << 1)
    public static let ProhibitsOverwriting = CEFV8AccessControl(rawValue: 1 << 2)
}

extension CEFV8AccessControl {
    func toCEF() -> cef_v8_accesscontrol_t {
        return cef_v8_accesscontrol_t(rawValue: UInt32(rawValue))
    }
}
