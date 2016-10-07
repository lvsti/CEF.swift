//
//  CEFV8StackFrame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFV8StackFrame {
    
    /// Returns true if the underlying handle is valid and it can be accessed on
    /// the current thread. Do not call any other methods if this method returns
    /// false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    /// Returns the name of the resource script that contains the function.
    /// CEF name: `GetScriptName`
    public var scriptName: String {
        let cefStrPtr = cefObject.get_script_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }

    /// Returns the name of the resource script that contains the function or the
    /// sourceURL value if the script name is undefined and its source ends with
    /// a "//@ sourceURL=..." string.
    /// CEF name: `GetScriptNameOrSourceURL`
    public var scriptNameOrSourceURL: String {
        let cefStrPtr = cefObject.get_script_name_or_source_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the name of the function.
    /// CEF name: `GetFunctionName`
    public var functionName: String {
        let cefStrPtr = cefObject.get_function_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }

    /// Returns the 1-based line number for the function call or 0 if unknown.
    /// CEF name: `GetLineNumber`
    public var lineNumber: Int? {
        let value = Int(cefObject.get_line_number(cefObjectPtr))
        return value != 0 ? value : nil
    }
    
    /// Returns the 1-based column offset on the line for the function call or 0 if
    /// unknown.
    /// CEF name: `GetColumn`
    public var column: Int? {
        let value = Int(cefObject.get_column(cefObjectPtr))
        return value != 0 ? value : nil
    }

    /// Returns true if the function was compiled using eval().
    /// CEF name: `IsEval`
    public var isEval: Bool {
        return cefObject.is_eval(cefObjectPtr) != 0
    }

    /// Returns true if the function was called as a constructor via "new".
    /// CEF name: `IsConstructor`
    public var isConstructor: Bool {
        return cefObject.is_constructor(cefObjectPtr) != 0
    }

}

