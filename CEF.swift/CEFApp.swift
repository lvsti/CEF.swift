//
//  CEFApp.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_app_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

class CEFApp: CEFBase<cef_app_t> {

    private static let _registryQueue = dispatch_queue_create("CEFApp.registry", nil)
    private static var _registry = [ObjectPtrType: CEFApp]()
    
    static func lookup(ptr: ObjectPtrType) -> CEFApp? {
        var obj:CEFApp? = nil
        dispatch_sync(CEFApp._registryQueue) {
            obj = _registry[ptr]
        }
        return obj
    }
    
    init?() {
        let app = ObjectPtrType.alloc(1)
        app.memory.base.add_ref = CEFApp_addRef
        app.memory.base.release = CEFApp_release
        app.memory.base.has_one_ref = CEFApp_hasOneRef
        app.memory.on_before_command_line_processing = CEFApp_onBeforeCommandLineProcessing
        app.memory.on_register_custom_schemes = CEFApp_onRegisterCustomSchemes
        app.memory.get_resource_bundle_handler = CEFApp_getResourceBundleHandler
        app.memory.get_browser_process_handler = CEFApp_getBrowserProcessHandler
        app.memory.get_render_process_handler = CEFApp_getRenderProcessHandler
        
        super.init(ptr: app)
        app.dealloc(1)
        
        dispatch_sync(CEFApp._registryQueue) {
            CEFApp._registry[app] = self
        }
    }

    func onBeforeCommandLineProcessing(processType processType: String, commandLine: CEFCommandLine) {
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

func CEFAppExecuteProcess(args: CEFMainArgs, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    let argsPtr = UnsafeMutablePointer<cef_main_args_t>.alloc(1)
    argsPtr.initialize(cefArgs)
    
    let retval = Int(cef_execute_process(argsPtr, app.toCEF(), nil))
    
    cefArgs.clear()
    argsPtr.dealloc(1)
    
    return retval
}

func CEFAppInitialize(args: CEFMainArgs, settings: CEFSettings, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    let argsPtr = UnsafeMutablePointer<cef_main_args_t>.alloc(1)
    argsPtr.initialize(cefArgs)
    
    var cefSettings = settings.toCEF()
    let settingsPtr = UnsafeMutablePointer<cef_settings_t>.alloc(1)
    settingsPtr.initialize(cefSettings)
    
    let retval = Int(cef_initialize(argsPtr, settingsPtr, app.toCEF(), nil))
    
    cefSettings.clear()
    settingsPtr.dealloc(1)
    
    cefArgs.clear()
    argsPtr.dealloc(1)
    
    return retval
}

func CEFAppShutdown() {
    cef_shutdown()
}

func CEFAppDoMessageLoopWork() {
    cef_do_message_loop_work()
}

func CEFAppQuitMessageLoop() {
    cef_quit_message_loop()
}


func CEFApp_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let wrapper = CEFApp.lookup(CEFApp.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.addRef()
}

func CEFApp_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFApp.lookup(CEFApp.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.release() ? 1 : 0
}

func CEFApp_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFApp.lookup(CEFApp.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.hasOneRef() ? 1 : 0
}


func CEFApp_onBeforeCommandLineProcessing(ptr: CEFApp.ObjectPtrType,
                                          procType: UnsafePointer<cef_string_t>,
                                          cmdLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let wrapper = CEFApp.lookup(ptr) else {
        return
    }
    
    wrapper.onBeforeCommandLineProcessing(processType: CEFStringToSwiftString(procType.memory),
                                          commandLine: CEFCommandLine.fromCEF(cmdLine)!)
}

func CEFApp_onRegisterCustomSchemes(ptr: CEFApp.ObjectPtrType,
                                    registrar: UnsafeMutablePointer<cef_scheme_registrar_t>) {
    guard let wrapper = CEFApp.lookup(ptr) else {
        return
    }
    
    wrapper.onRegisterCustomSchemes(CEFSchemeRegistrar.fromCEF(registrar)!)
}

func CEFApp_getResourceBundleHandler(ptr: CEFApp.ObjectPtrType) -> UnsafeMutablePointer<cef_resource_bundle_handler_t> {
    guard let wrapper = CEFApp.lookup(ptr) else {
        return nil
    }
    
    if let handler = wrapper.getResourceBundleHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_getBrowserProcessHandler(ptr: CEFApp.ObjectPtrType) -> UnsafeMutablePointer<cef_browser_process_handler_t> {
    guard let wrapper = CEFApp.lookup(ptr) else {
        return nil
    }
    
    if let handler = wrapper.getBrowserProcessHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_getRenderProcessHandler(ptr: CEFApp.ObjectPtrType) -> UnsafeMutablePointer<cef_render_process_handler_t> {
    guard let wrapper = CEFApp.lookup(ptr) else {
        return nil
    }
    
    if let handler = wrapper.getRenderProcessHandler() {
        return handler.toCEF()
    }
    
    return nil
}

