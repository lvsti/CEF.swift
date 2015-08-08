//
//  CEFApp.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFApp {
    func onBeforeCommandLineProcessing(processType processType: String?, commandLine: CEFCommandLine)
    func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar)
    func getResourceBundleHandler() -> CEFResourceBundleHandler?
    func getBrowserProcessHandler() -> CEFBrowserProcessHandler?
    func getRenderProcessHandler() -> CEFRenderProcessHandler?
}

public extension CEFApp {
    
    func onBeforeCommandLineProcessing(processType processType: String?, commandLine: CEFCommandLine) {
    }
    
    func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar) {
    }
    
    func getResourceBundleHandler() -> CEFResourceBundleHandler? {
        return nil
    }
    
    func getBrowserProcessHandler() -> CEFBrowserProcessHandler? {
        return nil
    }
    
    func getRenderProcessHandler() -> CEFRenderProcessHandler? {
        return nil
    }
    
}

