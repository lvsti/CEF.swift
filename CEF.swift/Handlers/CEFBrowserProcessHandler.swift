//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Class used to implement browser process callbacks. The methods of this class
// will be called on the browser process main thread unless otherwise indicated.
///
public protocol CEFBrowserProcessHandler {
    
    ///
    // Called on the browser process UI thread immediately after the CEF context
    // has been initialized.
    ///
    func onContextInitialized()

    ///
    // Called before a child process is launched. Will be called on the browser
    // process UI thread when launching a render process and on the browser
    // process IO thread when launching a GPU or plugin process. Provides an
    // opportunity to modify the child process command line. Do not keep a
    // reference to |command_line| outside of this method.
    ///
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine)
    
    ///
    // Called on the browser process IO thread after the main thread has been
    // created for a new render process. Provides an opportunity to specify extra
    // information that will be passed to
    // CefRenderProcessHandler::OnRenderThreadCreated() in the render process. Do
    // not keep a reference to |extra_info| outside of this method.
    ///
    func onRenderProcessThreadCreated(userInfo: CEFListValue)
    
    ///
    // Return the handler for printing on Linux. If a print handler is not
    // provided then printing will not be supported on the Linux platform.
    ///
    func getPrintHandler() -> CEFPrintHandler?

}

public extension CEFBrowserProcessHandler {

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }

    func getPrintHandler() -> CEFPrintHandler? {
        return nil
    }

}
