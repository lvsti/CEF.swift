//
//  CEFApp.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFApp: CEFHandler {
    
    public override init() {
        super.init()
    }
    
    public func onBeforeCommandLineProcessing(processType processType: String?, commandLine: CEFCommandLine) {
    }

    public func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar) {
    }

    public func getResourceBundleHandler() -> CEFResourceBundleHandler? {
        return nil
    }

    public func getBrowserProcessHandler() -> CEFBrowserProcessHandler? {
        return nil
    }
    
    public func getRenderProcessHandler() -> CEFRenderProcessHandler? {
        return nil
    }
    
}

public func CEFExecuteProcess(args: CEFMainArgs, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    defer { cefArgs.clear() }
    return Int(cef_execute_process(&cefArgs, app.toCEF(), nil))
}

public func CEFInitialize(args: CEFMainArgs, settings: CEFSettings, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    var cefSettings = settings.toCEF()
    defer {
        cefArgs.clear()
        cefSettings.clear()
    }
    return Int(cef_initialize(&cefArgs, &cefSettings, app.toCEF(), nil))
}

public func CEFShutdown() {
    cef_shutdown()
}

public func CEFDoMessageLoopWork() {
    cef_do_message_loop_work()
}

public func CEFRunMessageLoop() {
    cef_run_message_loop()
}

public func CEFQuitMessageLoop() {
    cef_quit_message_loop()
}


