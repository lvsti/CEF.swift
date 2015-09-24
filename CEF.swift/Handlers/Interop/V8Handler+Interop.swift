//
//  V8Handler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func V8Handler_execute(ptr: UnsafeMutablePointer<cef_v8handler_t>,
                       name: UnsafePointer<cef_string_t>,
                       object: UnsafeMutablePointer<cef_v8value_t>,
                       argCount: Int,
                       args: UnsafePointer<UnsafeMutablePointer<cef_v8value_t>>,
                       retval retvalPtr: UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>,
                       exception excStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = V8HandlerMarshaller.get(ptr) else {
        return 0
    }

    var arguments = [V8Value]()
    for i in 0..<argCount {
        arguments.append(V8Value.fromCEF(args.advancedBy(i).memory)!)
    }
    
    let optResult = obj.execute(CEFStringToSwiftString(name.memory),
                                object: V8Value.fromCEF(object)!,
                                arguments: arguments)
    
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

