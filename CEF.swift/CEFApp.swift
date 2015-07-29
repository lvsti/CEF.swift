//
//  CEFApp.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_app_t: CEFObject {
}

struct ext_cef_app_t {
    var cefStruct: cef_app_t
    var swiftObjPtr: UnsafeMutablePointer<Void>
}

typealias CEFAppMarshaller = CEFMarshaller<CEFApp>

public class CEFApp: CEFHandler, CEFMarshallable {
    typealias StructType = cef_app_t
    
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
    
    func toCEF() -> UnsafeMutablePointer<cef_app_t> {
        return CEFAppMarshaller.pass(self)
    }

    func marshalCallbacks(inout cefStruct: cef_app_t) {
        cefStruct.on_before_command_line_processing = CEFApp_onBeforeCommandLineProcessing
        cefStruct.on_register_custom_schemes = CEFApp_onRegisterCustomSchemes
        cefStruct.get_resource_bundle_handler = CEFApp_getResourceBundleHandler
        cefStruct.get_browser_process_handler = CEFApp_getBrowserProcessHandler
        cefStruct.get_render_process_handler = CEFApp_getRenderProcessHandler
    }
}

public func CEFExecuteProcess(args: CEFMainArgs, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    let argsPtr = UnsafeMutablePointer<cef_main_args_t>.alloc(1)
    argsPtr.initialize(cefArgs)

    defer {
        cefArgs.clear()
        argsPtr.dealloc(1)
    }

    return Int(cef_execute_process(argsPtr, app.toCEF(), nil))
}

public func CEFInitialize(args: CEFMainArgs, settings: CEFSettings, app: CEFApp) -> Int {
    var cefArgs = args.toCEF()
    let argsPtr = UnsafeMutablePointer<cef_main_args_t>.alloc(1)
    argsPtr.initialize(cefArgs)

    defer {
        cefArgs.clear()
        argsPtr.dealloc(1)
    }
    
    var cefSettings = settings.toCEF()
    let settingsPtr = UnsafeMutablePointer<cef_settings_t>.alloc(1)
    settingsPtr.initialize(cefSettings)

    defer {
        cefSettings.clear()
        settingsPtr.dealloc(1)
    }
    
    return Int(cef_initialize(argsPtr, settingsPtr, app.toCEF(), nil))
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


func CEFApp_onBeforeCommandLineProcessing(ptr: UnsafeMutablePointer<cef_app_t>,
                                          procType: UnsafePointer<cef_string_t>,
                                          cmdLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return
    }
    
    let processType: String? = procType != nil ? CEFStringToSwiftString(procType.memory) : nil
    obj.onBeforeCommandLineProcessing(processType: processType,
                                      commandLine: CEFCommandLine.fromCEF(cmdLine)!)
}

func CEFApp_onRegisterCustomSchemes(ptr: UnsafeMutablePointer<cef_app_t>,
                                    registrar: UnsafeMutablePointer<cef_scheme_registrar_t>) {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return
    }
    
    obj.onRegisterCustomSchemes(CEFSchemeRegistrar.fromCEF(registrar)!)
}

func CEFApp_getResourceBundleHandler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_resource_bundle_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getResourceBundleHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_getBrowserProcessHandler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_browser_process_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getBrowserProcessHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_getRenderProcessHandler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_render_process_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getRenderProcessHandler() {
        return handler.toCEF()
    }
    
    return nil
}

