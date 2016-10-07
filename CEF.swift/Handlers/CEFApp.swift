//
//  CEFApp.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations. Methods will be
/// called by the process and/or thread indicated.
/// CEF name: `CefApp`
public protocol CEFApp {
    /// Provides an opportunity to view and/or modify command-line arguments before
    /// processing by CEF and Chromium. The |process_type| value will be empty for
    /// the browser process. Do not keep a reference to the CefCommandLine object
    /// passed to this method. The CefSettings.command_line_args_disabled value
    /// can be used to start with an empty command-line object. Any values
    /// specified in CefSettings that equate to command-line arguments will be set
    /// before this method is called. Be cautious when using this method to modify
    /// command-line arguments for non-browser processes as this may result in
    /// undefined behavior including crashes.
    /// CEF name: `OnBeforeCommandLineProcessing`
    func onBeforeCommandLineProcessing(processType: String?, commandLine: CEFCommandLine)

    /// Provides an opportunity to register custom schemes. Do not keep a reference
    /// to the |registrar| object. This method is called on the main thread for
    /// each process and the registered schemes should be the same across all
    /// processes.
    /// CEF name: `OnRegisterCustomSchemes`
    func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar)
    
    /// Return the handler for resource bundle events. If
    /// CefSettings.pack_loading_disabled is true a handler must be returned. If no
    /// handler is returned resources will be loaded from pack files. This method
    /// is called by the browser and render processes on multiple threads.
    /// CEF name: `GetResourceBundleHandler`
    var resourceBundleHandler: CEFResourceBundleHandler? { get }
    
    /// Return the handler for functionality specific to the browser process. This
    /// method is called on multiple threads in the browser process.
    /// CEF name: `GetBrowserProcessHandler`
    var browserProcessHandler: CEFBrowserProcessHandler? { get }
    
    /// Return the handler for functionality specific to the render process. This
    /// method is called on the render process main thread.
    /// CEF name: `GetRenderProcessHandler`
    var renderProcessHandler: CEFRenderProcessHandler? { get }
}

public extension CEFApp {
    
    func onBeforeCommandLineProcessing(processType: String?, commandLine: CEFCommandLine) {
    }
    
    func onRegisterCustomSchemes(registrar: CEFSchemeRegistrar) {
    }
    
    var resourceBundleHandler: CEFResourceBundleHandler? { return nil }
    var browserProcessHandler: CEFBrowserProcessHandler? { return nil }
    var renderProcessHandler: CEFRenderProcessHandler? { return nil }
}

