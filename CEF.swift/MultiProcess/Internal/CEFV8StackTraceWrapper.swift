//
//  CEFV8StackTraceWrapper.swift
//  CEF.swift
//
//  Created by Morris on 26/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFV8StackTraceWrapper: ICEFV8StackTrace {

    /// Returns true if the underlying handle is valid and it can be accessed on
    /// the current thread. Do not call any other methods if this method returns
    /// false.
    /// CEF name: `IsValid`
    public var isValid: Bool { return false }

    /// Returns the number of stack frames.
    /// CEF name: `GetFrameCount`
    public var frameCount: Int { return 0 }

    /// Returns the stack frame at the specified 0-based index.
    /// CEF name: `GetFrame`
    public func frame(at index: Int) -> CEFV8StackFrame? { return nil }
}
