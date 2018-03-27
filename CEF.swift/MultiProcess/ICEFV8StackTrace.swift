//
//  ICEFV8StackTrace.swift
//  CEF.swift
//
//  Created by Morris on 26/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol ICEFV8StackTrace {

    /// Returns true if the underlying handle is valid and it can be accessed on
    /// the current thread. Do not call any other methods if this method returns
    /// false.
    /// CEF name: `IsValid`
    var isValid: Bool { get }

    /// Returns the number of stack frames.
    /// CEF name: `GetFrameCount`
    var frameCount: Int { get }

    /// Returns the stack frame at the specified 0-based index.
    /// CEF name: `GetFrame`
    func frame(at index: Int) -> CEFV8StackFrame?
}
