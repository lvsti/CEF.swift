//
//  CEFTaskRunner.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_task_runner_t: CEFObject {
}


public class CEFTaskRunner: CEFProxy<cef_task_runner_t> {

    public static func getForCurrentThread() -> CEFTaskRunner? {
        return CEFTaskRunner.fromCEF(cef_task_runner_get_for_current_thread())
    }
    
    public static func getForThread(threadID: CEFThreadID) -> CEFTaskRunner? {
        return CEFTaskRunner.fromCEF(cef_task_runner_get_for_thread(threadID.toCEF()))
    }

    public func isSame(other: CEFTaskRunner) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func belongsToCurrentThread() -> Bool {
        return cefObject.belongs_to_current_thread(cefObjectPtr) != 0
    }

    public func belongsToThread(threadID: CEFThreadID) -> Bool {
        return cefObject.belongs_to_thread(cefObjectPtr, threadID.toCEF()) != 0
    }

    public func postTask(task: CEFTask) -> Bool {
        return cefObject.post_task(cefObjectPtr, task.toCEF()) != 0
    }

    public func postDelayedTask(task: CEFTask, delayInMsec delay: Int64) -> Bool {
        return cefObject.post_delayed_task(cefObjectPtr, task.toCEF(), delay) != 0
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFTaskRunner? {
        return CEFTaskRunner(ptr: ptr)
    }
}


func CEFCurrentlyOn(thread threadID: CEFThreadID) -> Bool {
    return cef_currently_on(threadID.toCEF()) != 0
}

func CEFPostTask(onThread threadID: CEFThreadID, task: CEFTask) -> Bool {
    return cef_post_task(threadID.toCEF(), task.toCEF()) != 0
}

func CEFPostDelayedTask(onThread threadID: CEFThreadID, task: CEFTask, delayInMsec delay: Int64) -> Bool {
    return cef_post_delayed_task(threadID.toCEF(), task.toCEF(), delay) != 0
}

