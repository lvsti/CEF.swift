//
//  CEFApp.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFApp_on_before_command_line_processing(ptr: UnsafeMutablePointer<cef_app_t>,
                                              procType: UnsafePointer<cef_string_t>,
                                              cmdLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return
    }
    
    let processType: String? = procType != nil ? CEFStringToSwiftString(procType.pointee) : nil
    obj.onBeforeCommandLineProcessing(processType: processType,
                                      commandLine: CEFCommandLine.fromCEF(cmdLine)!)
}

func CEFApp_on_register_custom_schemes(ptr: UnsafeMutablePointer<cef_app_t>,
                                       registrar: UnsafeMutablePointer<cef_scheme_registrar_t>) {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return
    }
    
    obj.onRegisterCustomSchemes(registrar: CEFSchemeRegistrar.fromCEF(registrar)!)
}

func CEFApp_get_resource_bundle_handler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_resource_bundle_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.resourceBundleHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_get_browser_process_handler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_browser_process_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.browserProcessHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFApp_get_render_process_handler(ptr: UnsafeMutablePointer<cef_app_t>) -> UnsafeMutablePointer<cef_render_process_handler_t> {
    guard let obj = CEFAppMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.renderProcessHandler {
        return handler.toCEF()
    }
    
    return nil
}

