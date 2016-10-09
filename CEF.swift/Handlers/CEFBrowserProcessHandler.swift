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
    
    /// Called on the browser process IO thread after the main thread has been
    /// created for a new render process. Provides an opportunity to specify extra
    /// information that will be passed to
    /// CefRenderProcessHandler::OnRenderThreadCreated() in the render process. Do
    /// not keep a reference to |extra_info| outside of this method.
    /// CEF name: `OnRenderProcessThreadCreated`
    func onRenderProcessThreadCreated(userInfo: CEFListValue)
    
    /// Return the handler for printing on Linux. If a print handler is not
    /// provided then printing will not be supported on the Linux platform.
    /// CEF name: `GetPrintHandler`
    var printHandler: CEFPrintHandler? { get }

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

}

public extension CEFBrowserProcessHandler {

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }

    var printHandler: CEFPrintHandler? { return nil }
    
    func onScheduleMessageLoopWork(delay: TimeInterval) {
    }
}
