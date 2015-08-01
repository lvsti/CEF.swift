//
//  CEFV8Accessor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFV8Accessor {
    
    func get(name: String, object: CEFV8Value, inout retval: CEFV8Value?, inout exception: String?) -> Bool
    func set(name: String, object: CEFV8Value, value: CEFV8Value, inout exception: String?) -> Bool
    
}

public extension CEFV8Accessor {

    func get(name: String, object: CEFV8Value, inout retval: CEFV8Value?, inout exception: String?) -> Bool {
        return false
    }
    
    func set(name: String, object: CEFV8Value, value: CEFV8Value, inout exception: String?) -> Bool {
        return false
    }
    
}

