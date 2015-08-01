//
//  CEFV8StackFrame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_v8stack_frame_t: CEFObject {
}

public class CEFV8StackFrame: CEFProxy<cef_v8stack_frame_t> {
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    public func getScriptName() -> String {
        let cefStrPtr = cefObject.get_script_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getScriptNameOrSourceURL() -> String {
        let cefStrPtr = cefObject.get_script_name_or_source_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getFunctionName() -> String {
        let cefStrPtr = cefObject.get_function_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getLineNumber() -> Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }
    
    public func getColumn() -> Int {
        return Int(cefObject.get_column(cefObjectPtr))
    }

    public func isEval() -> Bool {
        return cefObject.is_eval(cefObjectPtr) != 0
    }

    public func isConstructor() -> Bool {
        return cefObject.is_constructor(cefObjectPtr) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8StackFrame? {
        return CEFV8StackFrame(ptr: ptr)
    }
}

