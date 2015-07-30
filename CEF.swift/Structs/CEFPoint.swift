//
//  CEFPoint.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFPoint {
    public var x:Int = 0
    public var y:Int = 0
    
    public var isEmpty: Bool { get { return x <= 0 && y <= 0 } }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public mutating func set(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func toCEF() -> cef_point_t {
        return cef_point_t(x: Int32(x), y: Int32(y))
    }
}

