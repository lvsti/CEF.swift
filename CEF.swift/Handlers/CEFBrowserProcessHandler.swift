//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFBrowserProcessHandler: CEFHandler {
    
    public override init() {
        super.init()
    }

    public func onContextInitialized() {
    }
    
    public func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    public func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }
    
    // TODO:
//    func getPrintHandler() -> CEFPrintHandler? {
//        return nil
//    }

}


