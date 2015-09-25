//
//  CEFTaskRunner.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFTaskRunner {

    /// Returns the task runner for the current thread. Only CEF threads will have
    /// task runners. An empty reference will be returned if this method is called
    /// on an invalid thread.
    public static func taskRunnerForCurrentThread() -> CEFTaskRunner? {
        return CEFTaskRunner.fromCEF(cef_task_runner_get_for_current_thread())
    }
    
    /// Returns the task runner for the specified CEF thread.
    public static func taskRunnerForThread(threadID: CEFThreadID) -> CEFTaskRunner? {
        return CEFTaskRunner.fromCEF(cef_task_runner_get_for_thread(threadID.toCEF()))
    }

    /// Returns true if this object is pointing to the same task runner as |that|
    /// object.
    public func isSameAs(other: CEFTaskRunner) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this task runner belongs to the current thread.
    public var belongsToCurrentThread: Bool {
        return cefObject.belongs_to_current_thread(cefObjectPtr) != 0
    }

    /// Returns true if this task runner is for the specified CEF thread.
    public func belongsToThread(threadID: CEFThreadID) -> Bool {
        return cefObject.belongs_to_thread(cefObjectPtr, threadID.toCEF()) != 0
    }

    /// Post a task for execution on the thread associated with this task runner.
    /// Execution will occur asynchronously.
    public func postTask(task: CEFTask) -> Bool {
        return cefObject.post_task(cefObjectPtr, task.toCEF()) != 0
    }

    /// Post a task for delayed execution on the thread associated with this task
    /// runner. Execution will occur asynchronously. Delayed tasks are not
    /// supported on V8 WebWorker threads and will be executed without the
    /// specified delay.
    public func postTask(task: CEFTask, withDelay delay: NSTimeInterval) -> Bool {
        return cefObject.post_delayed_task(cefObjectPtr, task.toCEF(), Int64(delay * 1000)) != 0
    }
    
}


public extension CEFTaskRunner {
    
    /// Post a task for execution on the thread associated with this task runner.
    /// Execution will occur asynchronously.
    public func postTask(block: CEFTaskExecuteBlock) -> Bool {
        let task = CEFTaskBridge(block: block)
        return cefObject.post_task(cefObjectPtr, task.toCEF()) != 0
    }
    
    /// Post a task for delayed execution on the thread associated with this task
    /// runner. Execution will occur asynchronously. Delayed tasks are not
    /// supported on V8 WebWorker threads and will be executed without the
    /// specified delay.
    public func postTaskWithDelay(delay: NSTimeInterval, block: CEFTaskExecuteBlock) -> Bool {
        let task = CEFTaskBridge(block: block)
        return cefObject.post_delayed_task(cefObjectPtr, task.toCEF(), Int64(delay * 1000)) != 0
    }
    
}

