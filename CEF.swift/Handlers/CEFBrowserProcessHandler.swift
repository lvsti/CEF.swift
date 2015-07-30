//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFBrowserProcessHandler {
    
    func onContextInitialized()
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine)
    func onRenderProcessThreadCreated(userInfo: CEFListValue)
    
    // TODO:
//    func getPrintHandler() -> CEFPrintHandler? {
//        return nil
//    }

}

public extension CEFBrowserProcessHandler {

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }

}
