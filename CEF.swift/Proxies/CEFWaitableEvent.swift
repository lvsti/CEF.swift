//
//  CEFWaitableEvent.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 12. 11..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFWaitableEvent {

    /// Create a new waitable event. If |automatic_reset| is true then the event
    /// state is automatically reset to un-signaled after a single waiting thread
    /// has been released; otherwise, the state remains signaled until Reset() is
    /// called manually. If |initially_signaled| is true then the event will start
    /// in the signaled state.
    /// CEF name: `CreateWaitableEvent`
    public convenience init?(automaticReset: Bool, signaledInitially: Bool) {
        self.init(ptr: cef_waitable_event_create(automaticReset ? 1 : 0, signaledInitially ? 1 : 0))
    }
    
    /// Put the event in the un-signaled state.
    /// CEF name: `Reset`
    public func reset() {
        cefObject.reset(cefObjectPtr)
    }
    
    /// Put the event in the signaled state. This causes any thread blocked on Wait
    /// to be woken up.
    /// CEF name: `Signal`
    public func signal() {
        cefObject.signal(cefObjectPtr)
    }
    
    /// Returns true if the event is in the signaled state, else false. If the
    /// event was created with |automatic_reset| set to true then calling this
    /// method will also cause a reset.
    /// CEF name: `IsSignaled`
    public var isSignaled: Bool {
        return cefObject.is_signaled(cefObjectPtr) != 0
    }
    
    /// Wait indefinitely for the event to be signaled. This method will not return
    /// until after the call to Signal() has completed. This method cannot be
    /// called on the browser process UI or IO threads.
    /// CEF name: `Wait`
    public func wait() {
        cefObject.wait(cefObjectPtr)
    }
    
    /// Wait up to |max_ms| milliseconds for the event to be signaled. Returns true
    /// if the event was signaled. A return value of false does not necessarily
    /// mean that |max_ms| was exceeded. This method will not return until after
    /// the call to Signal() has completed. This method cannot be called on the
    /// browser process UI or IO threads.
    /// CEF name: `TimedWait`
    public func wait(for seconds: TimeInterval) -> Bool {
        return cefObject.timed_wait(cefObjectPtr, int64(seconds*1000)) != 0
    }
}
