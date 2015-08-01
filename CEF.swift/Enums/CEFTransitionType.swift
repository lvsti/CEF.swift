//
//  CEFTransitionType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFTransitionType: RawRepresentable {
    public let rawValue: UInt
    
    public enum Source: UInt8 {
        case Link = 0
        case Explicit
        case AutoSubframe
        case ManualSubframe
        case FormSubmit
        case Reload
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        public static let Blocked = Flags(rawValue: 0x00800000)
        public static let ForwardBack = Flags(rawValue: 0x01000000)
        public static let ChainStart = Flags(rawValue: 0x10000000)
        public static let ChainEnd = Flags(rawValue: 0x20000000)
        public static let ClientRedirect = Flags(rawValue: 0x40000000)
        public static let ServerRedirect = Flags(rawValue: 0x80000000)
        
        public var isRedirect: Bool { return self.contains(.ClientRedirect) || self.contains(.ServerRedirect) }
    }
    
    public var source: Source { get { return Source(rawValue: UInt8(UInt32(rawValue) & TT_SOURCE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & TT_QUALIFIER_MASK.rawValue)) } }
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    static func fromCEF(value: cef_transition_type_t) -> CEFTransitionType {
        return CEFTransitionType(rawValue: UInt(value.rawValue))
    }
}

