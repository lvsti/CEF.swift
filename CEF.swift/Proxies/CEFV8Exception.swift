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

/// Class representing a V8 exception. The methods of this class may be called on
/// any render process thread.
public class CEFV8Exception: CEFProxy<cef_v8exception_t> {
    
    /// Returns the exception message.
    public func getMessage() -> String {
        let cefStrPtr = cefObject.get_message(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    /// Returns the line of source code that the exception occurred within.
    public func getSourceLine() -> String {
        let cefStrPtr = cefObject.get_source_line(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the resource name for the script from where the function causing
    /// the error originates.
    public func getScriptResourceName() -> String {
        let cefStrPtr = cefObject.get_script_resource_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the 1-based number of the line where the error occurred or 0 if the
    /// line number is unknown.
    public func getLineNumber() -> Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }

    /// Returns the index within the script of the first character where the error
    /// occurred.
    public func getStartPosition() -> Int {
        return Int(cefObject.get_start_position(cefObjectPtr))
    }
    
    /// Returns the index within the script of the last character where the error
    /// occurred.
    public func getEndPosition() -> Int {
        return Int(cefObject.get_end_position(cefObjectPtr))
    }
    
    /// Returns the index within the line of the first character where the error
    /// occurred.
    public func getStartColumn() -> Int {
        return Int(cefObject.get_start_column(cefObjectPtr))
    }
    
    /// Returns the index within the line of the last character where the error
    /// occurred.
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

