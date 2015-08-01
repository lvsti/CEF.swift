//
//  CEFV8Handler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_v8handler_t: CEFObject {
}

extension cef_v8handler_t: CEFWrappable {
    typealias WrapperType = CEFV8Handler
}

typealias CEFV8HandlerMarshaller = CEFMarshaller<CEFV8Handler, cef_v8handler_t>

extension CEFV8Handler {
    func toCEF() -> UnsafeMutablePointer<cef_v8handler_t> {
        return CEFV8HandlerMarshaller.pass(self)
    }
}

extension cef_v8handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        execute = CEFV8Handler_execute
    }
}

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
        arguments.append(CEFV8Value.fromCEF(args.advancedBy(i).memory)!)
    }
    var retval: CEFV8Value? = nil
    var excStr: String? = nil
    
    let result = obj.execute(CEFStringToSwiftString(name.memory),
                             object: CEFV8Value.fromCEF(object)!,
                             arguments: arguments,
                             retval: &retval,
                             exception: &excStr)
    
    if result {
        if let retval = retval {
            retvalPtr.memory = retval.toCEF()
        } else {
            retvalPtr.memory = nil
        }
    }
    
    if let excStr = excStr {
        CEFStringSetFromSwiftString(excStr, cefString: excStrPtr)
    }
    
    return result ? 1 : 0
}

