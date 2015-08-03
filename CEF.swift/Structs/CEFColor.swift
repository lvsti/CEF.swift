//
//  CEFColor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFColor {
    public var r: UInt8
    public var g: UInt8
    public var b: UInt8
    public var a: UInt8
    public var argb: UInt32 { get { return UInt32(a) << 24 | UInt32(r) << 16 | UInt32(g) << 8 | UInt32(b) } }
    
    public init(argb: UInt32) {
        r = UInt8((argb >> 16) & 0xff)
        g = UInt8((argb >> 8) & 0xff)
        b = UInt8(argb & 0xff)
        a = UInt8((argb >> 24) & 0xff)
    }
    
    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = UInt8.max) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    public static let Transparent = CEFColor(argb: 0)
}

extension CEFColor {
    func toCEF() -> cef_color_t {
        return cef_color_t(argb)
    }
}

