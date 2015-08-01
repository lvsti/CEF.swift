//
//  CEFV8Handler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFV8Handler {
    
    func execute(name: String,
                 object: CEFV8Value,
                 arguments: [CEFV8Value],
                 inout retval: CEFV8Value?,
                 inout exception: String?) -> Bool

}

public extension CEFV8Handler {
    
    func execute(name: String,
                 object: CEFV8Value,
                 arguments: [CEFV8Value],
                 inout retval: CEFV8Value?,
                 inout exception: String?) -> Bool {
        return false
    }
    
}

