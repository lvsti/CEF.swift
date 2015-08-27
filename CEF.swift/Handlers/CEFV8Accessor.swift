//
//  CEFV8Accessor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface that should be implemented to handle V8 accessor calls. Accessor
// identifiers are registered by calling CefV8Value::SetValue(). The methods
// of this class will be called on the thread associated with the V8 accessor.
///
public protocol CEFV8Accessor {
    
    ///
    // Handle retrieval the accessor value identified by |name|. |object| is the
    // receiver ('this' object) of the accessor. If retrieval succeeds set
    // |retval| to the return value. If retrieval fails set |exception| to the
    // exception that will be thrown. Return true if accessor retrieval was
    // handled.
    ///
    func get(name: String, object: CEFV8Value, inout retval: CEFV8Value?, inout exception: String?) -> Bool

    ///
    // Handle assignment of the accessor value identified by |name|. |object| is
    // the receiver ('this' object) of the accessor. |value| is the new value
    // being assigned to the accessor. If assignment fails set |exception| to the
    // exception that will be thrown. Return true if accessor assignment was
    // handled.
    ///
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

