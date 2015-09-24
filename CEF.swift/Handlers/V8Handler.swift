//
//  V8Handler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface that should be implemented to handle V8 function calls. The methods
/// of this class will be called on the thread associated with the V8 function.
public protocol V8Handler {
    
    /// Handle execution of the function identified by |name|. |object| is the
    /// receiver ('this' object) of the function. |arguments| is the list of
    /// arguments passed to the function. If execution succeeds set |retval| to the
    /// function return value. If execution fails set |exception| to the exception
    /// that will be thrown. Return true if execution was handled.
    func execute(name: String,
                 object: V8Value,
                 arguments: [V8Value]) -> V8Result?

}

public extension V8Handler {
    
    func execute(name: String,
                 object: V8Value,
                 arguments: [V8Value]) -> V8Result? {
        return nil
    }
    
}

