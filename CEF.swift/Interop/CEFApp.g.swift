//
//  CEFApp.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_app_t: CEFObject {
}

typealias CEFAppMarshaller = CEFMarshaller<CEFApp, cef_app_t>

extension CEFApp {
    func toCEF() -> UnsafeMutablePointer<cef_app_t> {
        return CEFAppMarshaller.pass(self)
    }
}

extension cef_app_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_command_line_processing = CEFApp_onBeforeCommandLineProcessing
        on_register_custom_schemes = CEFApp_onRegisterCustomSchemes
        get_resource_bundle_handler = CEFApp_getResourceBundleHandler
        get_browser_process_handler = CEFApp_getBrowserProcessHandler
        get_render_process_handler = CEFApp_getRenderProcessHandler
    }
}


func CEFApp_onBeforeCommandLineProcessing(ptr: UnsafeMutablePointer<cef_app_t>,
                                          procType: UnsafePointer<cef_string_t>,
                                          cmdLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return
    }
    
    let processType: String? = procType != nil ? CEFStringToSwiftString(procType.memory) : nil
    obj.onBeforeCommandLineProcessing(processType,
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

