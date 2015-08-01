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

public class CEFV8StackTrace: CEFProxy<cef_v8stack_trace_t> {
    
    public static func getCurrent(frameLimit: Int) -> CEFV8StackTrace? {
        let cefTrace = cef_v8stack_trace_get_current(Int32(frameLimit))
        return CEFV8StackTrace.fromCEF(cefTrace)
    }
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func getFrameCount() -> Int {
        return Int(cefObject.get_frame_count(cefObjectPtr))
    }

    public func getFrame(atIndex index: Int) -> CEFV8StackFrame? {
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

