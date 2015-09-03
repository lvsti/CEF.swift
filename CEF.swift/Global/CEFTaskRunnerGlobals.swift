//
//  CEFTaskRunnerGlobals.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Returns true if called on the specified thread. Equivalent to using
/// CefTaskRunner::GetForThread(threadId)->BelongsToCurrentThread().
public func CEFCurrentlyOn(thread threadID: CEFThreadID) -> Bool {
    return cef_currently_on(threadID.toCEF()) != 0
}

/// Post a task for execution on the specified thread. Equivalent to
/// using CefTaskRunner::GetForThread(threadId)->PostTask(task).
public func CEFPostTask(onThread threadID: CEFThreadID, task: CEFTask) -> Bool {
    return cef_post_task(threadID.toCEF(), task.toCEF()) != 0
}

/// Post a task for execution on the specified thread. Equivalent to
/// using CefTaskRunner::GetForThread(threadId)->PostTask(task).
public func CEFPostTask(onThread threadID: CEFThreadID, block: CEFTaskExecuteBlock) -> Bool {
    return CEFPostTask(onThread: threadID, task: CEFTaskBridge(block: block))
}

/// Post a task for delayed execution on the specified thread. Equivalent to
/// using CefTaskRunner::GetForThread(threadId)->PostDelayedTask(task, delay_ms).
public func CEFPostDelayedTask(onThread threadID: CEFThreadID, task: CEFTask, delayInMsec delay: Int64) -> Bool {
    return cef_post_delayed_task(threadID.toCEF(), task.toCEF(), delay) != 0
}

/// Post a task for delayed execution on the specified thread. Equivalent to
/// using CefTaskRunner::GetForThread(threadId)->PostDelayedTask(task, delay_ms).
public func CEFPostDelayedTask(onThread threadID: CEFThreadID, delayInMsec delay: Int64, block: CEFTaskExecuteBlock) -> Bool {
    return CEFPostDelayedTask(onThread: threadID, task: CEFTaskBridge(block: block), delayInMsec: delay)
}
