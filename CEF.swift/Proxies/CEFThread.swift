//
//  CEFThread.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 12. 11..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFPlatformThreadID = cef_platform_thread_id_t

public extension CEFThread {
    /// Create and start a new thread. This method does not block waiting for the
    /// thread to run initialization. |display_name| is the name that will be used
    /// to identify the thread. |priority| is the thread execution priority.
    /// |message_loop_type| indicates the set of asynchronous events that the
    /// thread can process. If |stoppable| is true the thread will stopped and
    /// joined on destruction or when Stop() is called; otherwise, the the thread
    /// cannot be stopped and will be leaked on shutdown. On Windows the
    /// |com_init_mode| value specifies how COM will be initialized for the thread.
    /// If |com_init_mode| is set to COM_INIT_MODE_STA then |message_loop_type|
    /// must be set to ML_TYPE_UI.
    /// CEF name: `CreateThread`
    public convenience init?(displayName: String? = nil,
                             priority: CEFThreadPriority,
                             messageLoopType: CEFMessageLoopType,
                             isStoppable: Bool,
                             COMInitMode mode: CEFCOMInitMode) {
        let cefStrPtr = displayName != nil ? CEFStringPtrCreateFromSwiftString(displayName!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }

        self.init(ptr: cef_thread_create(cefStrPtr,
                                         priority.toCEF(),
                                         messageLoopType.toCEF(),
                                         isStoppable ? 1 : 0,
                                         mode.toCEF()))
    }
    
    /// Create and start a new thread with default/recommended values.
    /// |display_name| is the name that will be used to identify the thread.
    /// CEF name: `CreateThread`
    public convenience init?(displayName: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(displayName)
        defer { CEFStringPtrRelease(cefStrPtr) }
        
        self.init(ptr: cef_thread_create(cefStrPtr,
                                         CEFThreadPriority.normal.toCEF(),
                                         CEFMessageLoopType.defaultLoopType.toCEF(),
                                         1,
                                         CEFCOMInitMode.none.toCEF()))
    }

    /// Returns the CefTaskRunner that will execute code on this thread's message
    /// loop. This method is safe to call from any thread.
    /// CEF name: `GetTaskRunner`
    public var taskRunner: CEFTaskRunner {
        let cefTaskRunner = cefObject.get_task_runner(cefObjectPtr)
        return CEFTaskRunner.fromCEF(cefTaskRunner)!
    }

    /// Returns the platform thread ID. It will return the same value after Stop()
    /// is called. This method is safe to call from any thread.
    /// CEF name: `GetPlatformThreadId`
    public var platformThreadID: CEFPlatformThreadID? {
        let cefThreadID = cefObject.get_platform_thread_id(cefObjectPtr)
        return cefThreadID != kInvalidPlatformThreadId ? cefThreadID : nil
    }

    /// Stop and join the thread. This method must be called from the same thread
    /// that called CreateThread(). Do not call this method if CreateThread() was
    /// called with a |stoppable| value of false.
    /// CEF name: `Stop`
    public func Stop() {
        cefObject.stop(cefObjectPtr)
    }

    /// Returns true if the thread is currently running. This method must be called
    /// from the same thread that called CreateThread().
    /// CEF name: `IsRunning`
    public var isRunning: Bool {
        return cefObject.is_running(cefObjectPtr) != 0
    }
}
