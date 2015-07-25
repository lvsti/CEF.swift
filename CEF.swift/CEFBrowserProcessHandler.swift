//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_browser_process_handler_t: CEFObject {
}

class CEFBrowserProcessHandlerMarshaller: CEFMarshaller<cef_browser_process_handler_t, CEFBrowserProcessHandler> {
    override init(obj: CEFBrowserProcessHandler) {
        super.init(obj: obj)
        cefStruct.on_context_initialized = CEFBrowserProcessHandler_onContextInitialized
        cefStruct.on_before_child_process_launch = CEFBrowserProcessHandler_onBeforeChildProcessLaunch
        cefStruct.on_render_process_thread_created = CEFBrowserProcessHandler_onRenderProcessThreadCreated
//        .get_print_handler = CEFBrowserProcessHandler_getPrintHandler
    }
}

public class CEFBrowserProcessHandler: CEFHandler {
    
    public override init() {
        super.init()
    }

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }
    
    // TODO:
//    func getPrintHandler() -> CEFPrintHandler? {
//        return nil
//    }

    func toCEF() -> UnsafeMutablePointer<cef_browser_process_handler_t> {
        return CEFBrowserProcessHandlerMarshaller.pass(self)
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


