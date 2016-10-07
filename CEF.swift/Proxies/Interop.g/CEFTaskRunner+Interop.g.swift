//
//  CEFTaskRunner+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_task.h.
//

import Foundation

extension cef_task_runner_t: CEFObject {}

/// Class that asynchronously executes tasks on the associated thread. It is safe
/// to call the methods of this class on any thread.
/// CEF maintains multiple internal threads that are used for handling different
/// types of tasks in different processes. The cef_thread_id_t definitions in
/// cef_types.h list the common CEF threads. Task runners are also available for
/// other CEF threads as appropriate (for example, V8 WebWorker threads).
/// CEF name: `CefTaskRunner`
public class CEFTaskRunner: CEFProxy<cef_task_runner_t> {
    override init?(ptr: UnsafeMutablePointer<cef_task_runner_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_task_runner_t>?) -> CEFTaskRunner? {
        return CEFTaskRunner(ptr: ptr)
    }
}

