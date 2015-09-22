//
//  MenuItemAccelerator.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 04..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct MenuItemAccelerator {
    public var keyCode: Int32 = 0
    public var shift: Bool = false
    public var control: Bool = false
    public var alt: Bool = false
    
    public init() {
    }
    
    public init(keyCode: Int32, shift: Bool, control: Bool, alt: Bool) {
        self.keyCode = keyCode
        self.shift = shift
        self.control = control
        self.alt = alt
    }
}

