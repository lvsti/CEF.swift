//
//  CEFThread+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_thread.h.
//

import Foundation

extension cef_thread_t: CEFObject {}

/// A simple thread abstraction that establishes a message loop on a new thread.
/// The consumer uses CefTaskRunner to execute code on the thread's message loop.
/// The thread is terminated when the CefThread object is destroyed or Stop() is
/// called. All pending tasks queued on the thread's message loop will run to
/// completion before the thread is terminated. CreateThread() can be called on
/// any valid CEF thread in either the browser or render process. This class
/// should only be used for tasks that require a dedicated thread. In most cases
/// you can post tasks to an existing CEF thread instead of creating a new one;
/// see cef_task.h for details.
/// CEF name: `CefThread`
public class CEFThread: CEFProxy<cef_thread_t> {
    override init?(ptr: UnsafeMutablePointer<cef_thread_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_thread_t>?) -> CEFThread? {
        return CEFThread(ptr: ptr)
    }
}

