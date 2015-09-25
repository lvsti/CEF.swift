//
//  CEFV8Exception.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFV8Exception {
    
    /// Returns the exception message.
    public var message: String {
        let cefStrPtr = cefObject.get_message(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    /// Returns the line of source code that the exception occurred within.
    public var sourceLine: String {
        let cefStrPtr = cefObject.get_source_line(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the resource name for the script from where the function causing
    /// the error originates.
    public var scriptResourceName: String {
        let cefStrPtr = cefObject.get_script_resource_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the 1-based number of the line where the error occurred or 0 if the
    /// line number is unknown.
    public var lineNumber: Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }

    /// Returns the index within the script of the first character where the error
    /// occurred.
    public var startPosition: Int {
        return Int(cefObject.get_start_position(cefObjectPtr))
    }
    
    /// Returns the index within the script of the last character where the error
    /// occurred.
    public var endPosition: Int {
        return Int(cefObject.get_end_position(cefObjectPtr))
    }
    
    /// Returns the index within the line of the first character where the error
    /// occurred.
    public var startColumn: Int {
        return Int(cefObject.get_start_column(cefObjectPtr))
    }
    
    /// Returns the index within the line of the last character where the error
    /// occurred.
    public var endColumn: Int {
        return Int(cefObject.get_end_column(cefObjectPtr))
    }
    
}

