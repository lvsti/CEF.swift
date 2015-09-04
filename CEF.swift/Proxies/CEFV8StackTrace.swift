//
//  CEFV8StackTrace.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_v8stack_trace_t: CEFObject {
}

/// Class representing a V8 stack trace handle. V8 handles can only be accessed
/// from the thread on which they are created. Valid threads for creating a V8
/// handle include the render process main thread (TID_RENDERER) and WebWorker
/// threads. A task runner for posting tasks on the associated thread can be
/// retrieved via the CefV8Context::GetTaskRunner() method.
public class CEFV8StackTrace: CEFProxy<cef_v8stack_trace_t> {
    
    /// Returns the stack trace for the currently active context. |frame_limit| is
    /// the maximum number of frames that will be captured.
    public static func getCurrent(frameLimit: Int) -> CEFV8StackTrace? {
        let cefTrace = cef_v8stack_trace_get_current(Int32(frameLimit))
        return CEFV8StackTrace.fromCEF(cefTrace)
    }
    
    /// Returns true if the underlying handle is valid and it can be accessed on
    /// the current thread. Do not call any other methods if this method returns
    /// false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns the number of stack frames.
    public var frameCount: Int {
        return Int(cefObject.get_frame_count(cefObjectPtr))
    }

    /// Returns the stack frame at the specified 0-based index.
    public func frameAtIndex(index: Int) -> CEFV8StackFrame? {
        let cefFrame = cefObject.get_frame(cefObjectPtr, Int32(index))
        return CEFV8StackFrame.fromCEF(cefFrame)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8StackTrace? {
        return CEFV8StackTrace(ptr: ptr)
    }
}

