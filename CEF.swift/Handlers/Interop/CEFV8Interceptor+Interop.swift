//
//  CEFV8Interceptor+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 05..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFV8Interceptor_get_byname(ptr: UnsafeMutablePointer<cef_v8interceptor_t>?,
                                 name: UnsafePointer<cef_string_t>?,
                                 object: UnsafeMutablePointer<cef_v8value_t>?,
                                 retval retvalPtr: UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>?>?,
                                 exception excStrPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFV8InterceptorMarshaller.get(ptr) else {
        return 0
    }
    
    let optResult = obj.get(name: CEFStringToSwiftString(name!.pointee),
                            object: CEFV8Value.fromCEF(object)!)
    
    guard let result = optResult else {
        return 0
    }
    
    switch result {
    case .success(let retval):
        retvalPtr!.pointee = retval.toCEF()
    case .failure(let excStr):
        CEFStringSetFromSwiftString(excStr, cefStringPtr: excStrPtr!)
    }
    
    return 1
}

func CEFV8Interceptor_get_byindex(ptr: UnsafeMutablePointer<cef_v8interceptor_t>?,
                                  index: Int32,
                                  object: UnsafeMutablePointer<cef_v8value_t>?,
                                  retval retvalPtr: UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>?>?,
                                  exception excStrPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFV8InterceptorMarshaller.get(ptr) else {
        return 0
    }
    
    let optResult = obj.get(index: Int(index),
                            object: CEFV8Value.fromCEF(object)!)
    
    guard let result = optResult else {
        return 0
    }
    
    switch result {
    case .success(let retval):
        retvalPtr!.pointee = retval.toCEF()
    case .failure(let excStr):
        CEFStringSetFromSwiftString(excStr, cefStringPtr: excStrPtr!)
    }
    
    return 1
}

func CEFV8Interceptor_set_byname(ptr: UnsafeMutablePointer<cef_v8interceptor_t>?,
                                 name: UnsafePointer<cef_string_t>?,
                                 object: UnsafeMutablePointer<cef_v8value_t>?,
                                 value: UnsafeMutablePointer<cef_v8value_t>?,
                                 exception excStrPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFV8InterceptorMarshaller.get(ptr) else {
        return 0
    }

    let optResult = obj.set(name: CEFStringToSwiftString(name!.pointee),
                            object: CEFV8Value.fromCEF(object)!,
                            value: CEFV8Value.fromCEF(value)!)

    guard let result = optResult else {
        return 0
    }
    
    if case .failure(let excStr) = result {
        CEFStringSetFromSwiftString(excStr, cefStringPtr: excStrPtr!)
    }
    
    return 1
}

func CEFV8Interceptor_set_byindex(ptr: UnsafeMutablePointer<cef_v8interceptor_t>?,
                                  index: Int32,
                                  object: UnsafeMutablePointer<cef_v8value_t>?,
                                  value: UnsafeMutablePointer<cef_v8value_t>?,
                                  exception excStrPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFV8InterceptorMarshaller.get(ptr) else {
        return 0
    }

    let optResult = obj.set(index: Int(index),
                            object: CEFV8Value.fromCEF(object)!,
                            value: CEFV8Value.fromCEF(value)!)

    guard let result = optResult else {
        return 0
    }
    
    if case .failure(let excStr) = result {
        CEFStringSetFromSwiftString(excStr, cefStringPtr: excStrPtr!)
    }
    
    return 1
}
