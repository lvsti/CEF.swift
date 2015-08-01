//
//  CEFV8Context.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_v8context_t: CEFObject {
}


public class CEFV8Context: CEFProxy<cef_v8context_t> {
    
    public static func getCurrentContext() -> CEFV8Context? {
        let cefCtx = cef_v8context_get_current_context()
        return CEFV8Context.fromCEF(cefCtx)
    }
    
    public static func getEnteredContext() -> CEFV8Context? {
        let cefCtx = cef_v8context_get_entered_context()
        return CEFV8Context.fromCEF(cefCtx)
    }

    public static func inContext() -> Bool {
        return cef_v8context_in_context() != 0
    }

    public func getTaskRunner() -> CEFTaskRunner? {
        let cefTaskRunner = cefObject.get_task_runner(cefObjectPtr)
        return CEFTaskRunner.fromCEF(cefTaskRunner)
    }
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func getBrowser() -> CEFBrowser? {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return CEFBrowser.fromCEF(cefBrowser)
    }

    public func getFrame() -> CEFFrame? {
        let cefFrame = cefObject.get_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    public func getGlobal() -> CEFV8Value? {
        let cefValue = cefObject.get_global(cefObjectPtr)
        return CEFV8Value.fromCEF(cefValue)
    }
    
    public func enter() -> Bool {
        return cefObject.enter(cefObjectPtr) != 0
    }

    public func exit() -> Bool {
        return cefObject.exit(cefObjectPtr) != 0
    }
    
    public func isSame(other: CEFV8Context) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func eval(code: String, inout retval: CEFV8Value, inout exception: CEFV8Exception) -> Bool {
        let cefCodePtr = CEFStringPtrCreateFromSwiftString(code)
        defer { CEFStringPtrRelease(cefCodePtr) }
        
        var cefRetval: UnsafeMutablePointer<cef_v8value_t> = nil
        var cefExc: UnsafeMutablePointer<cef_v8exception_t> = nil
        let result = cefObject.eval(cefObjectPtr, cefCodePtr, &cefRetval, &cefExc)
        
        if result != 0 {
            retval = CEFV8Value.fromCEF(cefRetval)!
        } else {
            exception = CEFV8Exception.fromCEF(cefExc)!
        }
        
        return result != 0
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8Context? {
        return CEFV8Context(ptr: ptr)
    }
}

