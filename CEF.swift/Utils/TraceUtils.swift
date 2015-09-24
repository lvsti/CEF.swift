//
//  TraceUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct TraceUtils {
    
    /// Start tracing events on all processes. Tracing is initialized asynchronously
    /// and |callback| will be executed on the UI thread after initialization is
    /// complete.
    /// If CefBeginTracing was called previously, or if a CefEndTracingAsync call is
    /// pending, CefBeginTracing will fail and return false.
    /// |categories| is a comma-delimited list of category wildcards. A category can
    /// have an optional '-' prefix to make it an excluded category. Having both
    /// included and excluded categories in the same list is not supported.
    /// Example: "test_MyTest*"
    /// Example: "test_MyTest*,test_OtherStuff"
    /// Example: "-excluded_category1,-excluded_category2"
    /// This function must be called on the browser process UI thread.
    public static func beginTracingWithCategories(categories: String? = nil, callback: CompletionCallback? = nil) -> Bool {
        let cefStrPtr = categories != nil ? CEFStringPtrCreateFromSwiftString(categories!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cef_begin_tracing(cefStrPtr, callback != nil ? callback!.toCEF() : nil) != 0
    }

    /// Stop tracing events on all processes.
    /// This function will fail and return false if a previous call to
    /// CefEndTracingAsync is already pending or if CefBeginTracing was not called.
    /// |tracing_file| is the path at which tracing data will be written and
    /// |callback| is the callback that will be executed once all processes have
    /// sent their trace data. If |tracing_file| is empty a new temporary file path
    /// will be used. If |callback| is empty no trace data will be written.
    /// This function must be called on the browser process UI thread.
    public static func endTracingWithOutputFilePath(path: String? = nil, callback: EndTracingCallback? = nil) -> Bool {
        let cefStrPtr = path != nil ? CEFStringPtrCreateFromSwiftString(path!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cef_end_tracing(cefStrPtr, callback != nil ? callback!.toCEF() : nil) != 0
    }

    /// Stop tracing events on all processes.
    /// This function will fail and return false if a previous call to
    /// CefEndTracingAsync is already pending or if CefBeginTracing was not called.
    /// |tracing_file| is the path at which tracing data will be written and
    /// |callback| is the callback that will be executed once all processes have
    /// sent their trace data. If |tracing_file| is empty a new temporary file path
    /// will be used. If |callback| is empty no trace data will be written.
    /// This function must be called on the browser process UI thread.
    public static func endTracingWithOutputFilePath(path: String? = nil, block: EndTracingCallbackOnEndTracingCompleteBlock) -> Bool {
        return endTracingWithOutputFilePath(path, callback: EndTracingCallbackBridge(block: block))
    }

    /// Returns the current system trace time or, if none is defined, the current
    /// high-res time. Can be used by clients to synchronize with the time
    /// information in trace events.
    public static func systemTraceTime() -> Int64 {
        return cef_now_from_system_trace_time()
    }

}
