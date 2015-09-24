//
//  V8Accessor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func V8Accessor_get(ptr: UnsafeMutablePointer<cef_v8accessor_t>,
                    name: UnsafePointer<cef_string_t>,
                    object: UnsafeMutablePointer<cef_v8value_t>,
                    retval retvalPtr: UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>,
                    exception excStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = V8AccessorMarshaller.get(ptr) else {
        return 0
    }

    let optResult = obj.get(CEFStringToSwiftString(name.memory),
                            object: V8Value.fromCEF(object)!)
    
    guard let result = optResult else {
        return 0
    }
    
    switch result {
    case .Success(let retval):
        retvalPtr.memory = retval.toCEF()
        break
    case .Failure(let excStr):
        CEFStringSetFromSwiftString(excStr, cefString: excStrPtr)
        break
    }
    
    return 1
}

func V8Accessor_set(ptr: UnsafeMutablePointer<cef_v8accessor_t>,
                    name: UnsafePointer<cef_string_t>,
                    object: UnsafeMutablePointer<cef_v8value_t>,
                    value: UnsafeMutablePointer<cef_v8value_t>,
                    exception excStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = V8AccessorMarshaller.get(ptr) else {
        return 0
    }

    let optResult = obj.set(CEFStringToSwiftString(name.memory),
                            object: V8Value.fromCEF(object)!,
                            value: V8Value.fromCEF(value)!)

    guard let result = optResult else {
        return 0
    }
    
    if case .Failure(let excStr) = result {
        CEFStringSetFromSwiftString(excStr, cefString: excStrPtr)
    }
    
    return 1
}

