//
//  CEFRenderProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRenderProcessHandler_onRenderThreadCreated(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                   info: UnsafeMutablePointer<cef_list_value_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderThreadCreated(CEFListValue.fromCEF(info)!)
}

func CEFRenderProcessHandler_onWebKitInitialized(ptr: UnsafeMutablePointer<cef_render_process_handler_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onWebKitInitialized()
}

func CEFRenderProcessHandler_onBrowserCreated(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                              browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserCreated(CEFBrowser.fromCEF(browser)!)
}

func CEFRenderProcessHandler_onBrowserDestroyed(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserDestroyed(CEFBrowser.fromCEF(browser)!)
}

func CEFRenderProcessHandler_getLoadHandler(ptr: UnsafeMutablePointer<cef_render_process_handler_t>) -> UnsafeMutablePointer<cef_load_handler_t> {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.getLoadHandler() {
        return handler.toCEF()
    }
    
    return nil
}

func CEFRenderProcessHandler_onBeforeNavigation(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                browser: UnsafeMutablePointer<cef_browser_t>,
                                                frame: UnsafeMutablePointer<cef_frame_t>,
                                                request: UnsafeMutablePointer<cef_request_t>,
                                                navType: cef_navigation_type_t,
                                                isRedirect: Int32) -> Int32 {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onBeforeNavigation(CEFBrowser.fromCEF(browser)!,
                                  frame: CEFFrame.fromCEF(frame)!,
                                  request: CEFRequest.fromCEF(request)!,
                                  navigationType: CEFNavigationType.fromCEF(navType),
                                  isRedirect: isRedirect != 0) ? 1 : 0
}

func CEFRenderProcessHandler_onContextCreated(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                              browser: UnsafeMutablePointer<cef_browser_t>,
                                              frame: UnsafeMutablePointer<cef_frame_t>,
                                              context: UnsafeMutablePointer<cef_v8context_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextCreated(CEFBrowser.fromCEF(browser)!,
                         frame: CEFFrame.fromCEF(frame)!,
                         context: CEFV8Context.fromCEF(context)!)
}

func CEFRenderProcessHandler_onContextReleased(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                               browser: UnsafeMutablePointer<cef_browser_t>,
                                               frame: UnsafeMutablePointer<cef_frame_t>,
                                               context: UnsafeMutablePointer<cef_v8context_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextReleased(CEFBrowser.fromCEF(browser)!,
                          frame: CEFFrame.fromCEF(frame)!,
                          context: CEFV8Context.fromCEF(context)!)
}

func CEFRenderProcessHandler_onUncaughtException(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 frame: UnsafeMutablePointer<cef_frame_t>,
                                                 context: UnsafeMutablePointer<cef_v8context_t>,
                                                 exception: UnsafeMutablePointer<cef_v8exception_t>,
                                                 trace: UnsafeMutablePointer<cef_v8stack_trace_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onUncaughtException(CEFBrowser.fromCEF(browser)!,
                            frame: CEFFrame.fromCEF(frame)!,
                            context: CEFV8Context.fromCEF(context)!,
                            exception: CEFV8Exception.fromCEF(exception)!,
                            stackTrace: CEFV8StackTrace.fromCEF(trace)!)
}

func CEFRenderProcessHandler_onFocusedNodeChanged(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                                  frame: UnsafeMutablePointer<cef_frame_t>,
                                                  node: UnsafeMutablePointer<cef_domnode_t>) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onFocusedNodeChanged(CEFBrowser.fromCEF(browser)!,
        frame: CEFFrame.fromCEF(frame),
        node: CEFDOMNode.fromCEF(node))
}

func CEFRenderProcessHandler_onProcessMessageReceived(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                                      processID: cef_process_id_t,
                                                      message:UnsafeMutablePointer<cef_process_message_t>) -> Int32 {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onProcessMessageReceived(CEFBrowser.fromCEF(browser)!,
                                        processID: CEFProcessID.fromCEF(processID),
                                        message: CEFProcessMessage.fromCEF(message)!) ? 1 : 0
}

