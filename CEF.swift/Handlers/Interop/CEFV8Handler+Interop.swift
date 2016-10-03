//
//  CEFV8Handler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFV8Handler_execute(ptr: UnsafeMutablePointer<cef_v8handler_t>,
                          name: UnsafePointer<cef_string_t>,
                          object: UnsafeMutablePointer<cef_v8value_t>,
                          argCount: Int,
                          args: UnsafePointer<UnsafeMutablePointer<cef_v8value_t>>,
                          retval retvalPtr: UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>,
                          exception excStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = CEFV8HandlerMarshaller.get(ptr) else {
        return 0
    }

    var arguments = [CEFV8Value]()
    for i in 0..<argCount {
        arguments.append(CEFV8Value.fromCEF(args.advanced(by: i).pointee)!)
    }
    
    let optResult = obj.execute(name: CEFStringToSwiftString(name.pointee),
                                object: CEFV8Value.fromCEF(object)!,
                                arguments: arguments)
    
    guard let result = optResult else {
        return 0
    }

    switch result {
    case .Success(let retval):
        retvalPtr.pointee = retval.toCEF()
        break
    case .Failure(let excStr):
        CEFStringSetFromSwiftString(excStr, cefString: excStrPtr)
        break
    }
    
    return 1
}

