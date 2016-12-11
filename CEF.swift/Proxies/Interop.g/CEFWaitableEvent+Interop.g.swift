//
//  CEFWaitableEvent+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_waitable_event.h.
//

import Foundation

extension cef_waitable_event_t: CEFObject {}

/// WaitableEvent is a thread synchronization tool that allows one thread to wait
/// for another thread to finish some work. This is equivalent to using a
/// Lock+ConditionVariable to protect a simple boolean value. However, using
/// WaitableEvent in conjunction with a Lock to wait for a more complex state
/// change (e.g., for an item to be added to a queue) is not recommended. In that
/// case consider using a ConditionVariable instead of a WaitableEvent. It is
/// safe to create and/or signal a WaitableEvent from any thread. Blocking on a
/// WaitableEvent by calling the *Wait() methods is not allowed on the browser
/// process UI or IO threads.
/// CEF name: `CefWaitableEvent`
public class CEFWaitableEvent: CEFProxy<cef_waitable_event_t> {
    override init?(ptr: UnsafeMutablePointer<cef_waitable_event_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_waitable_event_t>?) -> CEFWaitableEvent? {
        return CEFWaitableEvent(ptr: ptr)
    }
}

