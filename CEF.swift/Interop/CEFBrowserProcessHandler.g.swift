//
//  CEFBrowserProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_browser_process_handler_t: CEFObject {
}

typealias CEFBrowserProcessHandlerMarshaller = CEFMarshaller<CEFBrowserProcessHandler>

extension CEFBrowserProcessHandler: CEFMarshallable {
    typealias StructType = cef_browser_process_handler_t

    func toCEF() -> UnsafeMutablePointer<cef_browser_process_handler_t> {
        return CEFBrowserProcessHandlerMarshaller.pass(self)
    }
    
    func marshalCallbacks(inout cefStruct: cef_browser_process_handler_t) {
        cefStruct.on_context_initialized = CEFBrowserProcessHandler_onContextInitialized
        cefStruct.on_before_child_process_launch = CEFBrowserProcessHandler_onBeforeChildProcessLaunch
        cefStruct.on_render_process_thread_created = CEFBrowserProcessHandler_onRenderProcessThreadCreated
    }
}

func CEFBrowserProcessHandler_onContextInitialized(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextInitialized()
}

func CEFBrowserProcessHandler_onBeforeChildProcessLaunch(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>,
                                                         commandLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeChildProcessLaunch(CEFCommandLine.fromCEF(commandLine)!)
}

func CEFBrowserProcessHandler_onRenderProcessThreadCreated(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>,
                                                           userInfo: UnsafeMutablePointer<cef_list_value_t>) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderProcessThreadCreated(CEFListValue.fromCEF(userInfo)!)
}
//
//func CEFBrowserProcessHandler_getPrintHandler(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>) -> UnsafeMutablePointer<cef_print_handler_t> {
//    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
//        return nil
//    }
//
//    return obj.getPrintHandler()
//}

