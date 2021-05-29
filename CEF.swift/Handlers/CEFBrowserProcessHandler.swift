//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class used to implement browser process callbacks. The methods of this class
/// will be called on the browser process main thread unless otherwise indicated.
/// CEF name: `CefBrowserProcessHandler`
public protocol CEFBrowserProcessHandler {

    /// Called on the browser process UI thread immediately after the CEF context
    /// has been initialized.
    /// CEF name: `OnContextInitialized`
    func onContextInitialized()

    /// Called before a child process is launched. Will be called on the browser
    /// process UI thread when launching a render process and on the browser
    /// process IO thread when launching a GPU or plugin process. Provides an
    /// opportunity to modify the child process command line. Do not keep a
    /// reference to |command_line| outside of this method.
    /// CEF name: `OnBeforeChildProcessLaunch`
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine)
    
    /// Called from any thread when work has been scheduled for the browser process
    /// main (UI) thread. This callback is used in combination with CefSettings.
    /// external_message_pump and CefDoMessageLoopWork() in cases where the CEF
    /// message loop must be integrated into an existing application message loop
    /// (see additional comments and warnings on CefDoMessageLoopWork). This
    /// callback should schedule a CefDoMessageLoopWork() call to happen on the
    /// main (UI) thread. |delay_ms| is the requested delay in milliseconds. If
    /// |delay_ms| is <= 0 then the call should happen reasonably soon. If
    /// |delay_ms| is > 0 then the call should be scheduled to happen after the
    /// specified delay and any currently pending scheduled call should be
    /// cancelled.
    /// CEF name: `OnScheduleMessagePumpWork`
    func onScheduleMessageLoopWork(delay: TimeInterval)

    /// Return the default client for use with a newly created browser window. If
    /// null is returned the browser will be unmanaged (no callbacks will be
    /// executed for that browser) and application shutdown will be blocked until
    /// the browser window is closed manually. This method is currently only used
    /// with the chrome runtime.
    /// CEF name: `GetDefaultClient`
    var defaultClient: CEFClient? { get }
}

public extension CEFBrowserProcessHandler {

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onScheduleMessageLoopWork(delay: TimeInterval) {
    }

    var defaultClient: CEFClient? { return nil }
}
