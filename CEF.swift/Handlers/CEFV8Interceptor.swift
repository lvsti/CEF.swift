//
//  CEFV8Interceptor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 05..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface that should be implemented to handle V8 interceptor calls. The
/// methods of this class will be called on the thread associated with the V8
/// interceptor. Interceptor's named property handlers (with first argument of
/// type CefString) are called when object is indexed by string. Indexed property
/// handlers (with first argument of type int) are called when object is indexed
/// by integer.
/// CEF name: `CefV8Interceptor`
public protocol CEFV8Interceptor {
    
    /// Handle retrieval of the interceptor value identified by |name|. |object| is
    /// the receiver ('this' object) of the interceptor. If retrieval succeeds, set
    /// |retval| to the return value. If the requested value does not exist, don't
    /// set either |retval| or |exception|. If retrieval fails, set |exception| to
    /// the exception that will be thrown. If the property has an associated
    /// accessor, it will be called only if you don't set |retval|.
    /// Return true if interceptor retrieval was handled, false otherwise.
    /// CEF name: `Get`
    func get(name: String, object: CEFV8Value) -> CEFV8Result?
    
    /// Handle retrieval of the interceptor value identified by |index|. |object|
    /// is the receiver ('this' object) of the interceptor. If retrieval succeeds,
    /// set |retval| to the return value. If the requested value does not exist,
    /// don't set either |retval| or |exception|. If retrieval fails, set
    /// |exception| to the exception that will be thrown.
    /// Return true if interceptor retrieval was handled, false otherwise.
    /// CEF name: `Get`
    func get(index: Int, object: CEFV8Value) -> CEFV8Result?
    
    /// Handle assignment of the interceptor value identified by |name|. |object|
    /// is the receiver ('this' object) of the interceptor. |value| is the new
    /// value being assigned to the interceptor. If assignment fails, set
    /// |exception| to the exception that will be thrown. This setter will always
    /// be called, even when the property has an associated accessor.
    /// Return true if interceptor assignment was handled, false otherwise.
    /// CEF name: `Set`
    func set(name: String, object: CEFV8Value, value: CEFV8Value) -> CEFV8VoidResult?
    
    /// Handle assignment of the interceptor value identified by |index|. |object|
    /// is the receiver ('this' object) of the interceptor. |value| is the new
    /// value being assigned to the interceptor. If assignment fails, set
    /// |exception| to the exception that will be thrown.
    /// Return true if interceptor assignment was handled, false otherwise.
    /// CEF name: `Set`
    func set(index: Int, object: CEFV8Value, value: CEFV8Value) -> CEFV8VoidResult?
    
}

public extension CEFV8Interceptor {

    func get(name: String, object: CEFV8Value) -> CEFV8Result? {
        return nil
    }
    
    func get(index: Int, object: CEFV8Value) -> CEFV8Result? {
        return nil
    }

    func set(name: String, object: CEFV8Value, value: CEFV8Value) -> CEFV8VoidResult? {
        return nil
    }
    
    func set(index: Int, object: CEFV8Value, value: CEFV8Value) -> CEFV8VoidResult? {
        return nil
    }

}
