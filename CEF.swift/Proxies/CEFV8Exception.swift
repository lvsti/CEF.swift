//
//  CEFV8Exception.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_v8exception_t: CEFObject {
}

public class CEFV8Exception: CEFProxy<cef_v8exception_t> {
    
    public func getMessage() -> String {
        let cefStrPtr = cefObject.get_message(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getSourceLine() -> String {
        let cefStrPtr = cefObject.get_source_line(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getScriptResourceName() -> String {
        let cefStrPtr = cefObject.get_script_resource_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getLineNumber() -> Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }

    public func getStartPosition() -> Int {
        return Int(cefObject.get_start_position(cefObjectPtr))
    }
    
    public func getEndPosition() -> Int {
        return Int(cefObject.get_end_position(cefObjectPtr))
    }
    
    public func getStartColumn() -> Int {
        return Int(cefObject.get_start_column(cefObjectPtr))
    }
    
    public func getEndColumn() -> Int {
        return Int(cefObject.get_end_column(cefObjectPtr))
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8Exception? {
        return CEFV8Exception(ptr: ptr)
    }
}

