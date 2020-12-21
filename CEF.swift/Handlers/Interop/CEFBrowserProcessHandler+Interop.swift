//
//  CEFBrowserProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFBrowserProcessHandler_get_cookieable_schemes(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?,
                                                     cefSchemes: cef_string_list_t?,
                                                     includeDefaults: UnsafeMutablePointer<Int32>?) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }

    let result = obj.getCookieableSchemes()
    switch result {
    case .none:
        return
    case .default:
        includeDefaults?.pointee = 1
    case .custom(let schemes):
        CEFStringListAppendToList(cefSchemes!, elements: schemes)
    case .customAndDefault(let schemes):
        includeDefaults?.pointee = 1
        CEFStringListAppendToList(cefSchemes!, elements: schemes)
    }
}

func CEFBrowserProcessHandler_on_context_initialized(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextInitialized()
}

func CEFBrowserProcessHandler_on_before_child_process_launch(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?,
                                                             commandLine: UnsafeMutablePointer<cef_command_line_t>?) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeChildProcessLaunch(commandLine: CEFCommandLine.fromCEF(commandLine)!)
}

func CEFBrowserProcessHandler_get_print_handler(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?) -> UnsafeMutablePointer<cef_print_handler_t>? {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.printHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFBrowserProcessHandler_on_schedule_message_pump_work(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?,
                                                            delay: Int64) {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onScheduleMessageLoopWork(delay: TimeInterval(delay*1000))
}

func CEFBrowserProcessHandler_get_default_client(ptr: UnsafeMutablePointer<cef_browser_process_handler_t>?) -> UnsafeMutablePointer<cef_client_t>? {
    guard let obj = CEFBrowserProcessHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let client = obj.defaultClient {
        return client.toCEF()
    }

    return nil
}
