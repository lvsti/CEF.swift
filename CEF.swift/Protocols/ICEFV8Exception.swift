//
//  ICEFV8Exception.swift
//  CEF.swift
//
//  Created by Morris on 23/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol ICEFV8Exception {
    var message: String { get }
    
    /// Returns the line of source code that the exception occurred within.
    /// CEF name: `GetSourceLine`
    var sourceLine: String { get }
    
    /// Returns the resource name for the script from where the function causing
    /// the error originates.
    /// CEF name: `GetScriptResourceName`
    var scriptResourceName: String { get }
    
    /// Returns the 1-based number of the line where the error occurred or 0 if the
    /// line number is unknown.
    /// CEF name: `GetLineNumber`
    var lineNumber: Int { get }
    
    /// Returns the index within the script of the first character where the error
    /// occurred.
    /// CEF name: `GetStartPosition`
    var startPosition: Int { get }
    
    /// Returns the index within the script of the last character where the error
    /// occurred.
    /// CEF name: `GetEndPosition`
    var endPosition: Int { get }
    
    /// Returns the index within the line of the first character where the error
    /// occurred.
    /// CEF name: `GetStartColumn`
    var startColumn: Int { get }
    
    /// Returns the index within the line of the last character where the error
    /// occurred.
    /// CEF name: `GetEndColumn`
    var endColumn: Int { get }
}
