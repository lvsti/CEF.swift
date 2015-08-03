//
//  CEFPoint.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFPoint {
    public var x:Int32 = 0
    public var y:Int32 = 0
    
    public var isEmpty: Bool { get { return x <= 0 && y <= 0 } }
    
    public init(x: Int32, y: Int32) {
        self.x = x
        self.y = y
    }
}

extension CEFPoint {
    func toCEF() -> cef_point_t {
        return cef_point_t(x: x, y: y)
    }
}

