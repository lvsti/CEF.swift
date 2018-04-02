//
//  CEFRenderProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRenderProcessHandler_on_render_thread_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                      info: UnsafeMutablePointer<cef_list_value_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderThreadCreated(info: CEFListValue.fromCEF(info)!)
}

func CEFRenderProcessHandler_on_web_kit_initialized(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onWebKitInitialized()
}

func CEFRenderProcessHandler_on_browser_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                browser: UnsafeMutablePointer<cef_browser_t>?) {
    let b = CEFBrowser.fromCEF(browser)!
    // Create a wrapper and cache it
    if !CEFSettings.CEFSingleProcessMode {
        _ = CEFBrowserWrapper(b)
    }

    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserCreated(browser: b)
}

func CEFRenderProcessHandler_on_browser_destroyed(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                  browser: UnsafeMutablePointer<cef_browser_t>?) {
    let b = CEFBrowser.fromCEF(browser)!
    if !CEFSettings.CEFSingleProcessMode {
        CEFBrowserWrapper.terminate(b.identifier)
    }

    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserDestroyed(browser: b)
}

func CEFRenderProcessHandler_get_load_handler(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?) -> UnsafeMutablePointer<cef_load_handler_t>? {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.loadHandler {
        return handler.toCEF()
    }
    
    return nil
}

func CEFRenderProcessHandler_on_before_navigation(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                  browser: UnsafeMutablePointer<cef_browser_t>?,
                                                  frame: UnsafeMutablePointer<cef_frame_t>?,
                                                  request: UnsafeMutablePointer<cef_request_t>?,
                                                  navType: cef_navigation_type_t,
                                                  isRedirect: Int32) -> Int32 {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onBeforeNavigation(browser: CEFBrowser.fromCEF(browser)!,
                                        frame: CEFFrame.fromCEF(frame)!,
                                        request: CEFRequest.fromCEF(request)!,
                                        navigationType: CEFNavigationType.fromCEF(navType),
                                        isRedirect: isRedirect != 0)
    return action == .cancel ? 1 : 0
}

func CEFRenderProcessHandler_on_context_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                browser: UnsafeMutablePointer<cef_browser_t>?,
                                                frame: UnsafeMutablePointer<cef_frame_t>?,
                                                context: UnsafeMutablePointer<cef_v8context_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextCreated(browser: CEFBrowser.fromCEF(browser)!,
                         frame: CEFFrame.fromCEF(frame)!)
}

func CEFRenderProcessHandler_on_context_released(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                 browser: UnsafeMutablePointer<cef_browser_t>?,
                                                 frame: UnsafeMutablePointer<cef_frame_t>?,
                                                 context: UnsafeMutablePointer<cef_v8context_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextReleased(browser: CEFBrowser.fromCEF(browser)!,
                          frame: CEFFrame.fromCEF(frame)!)
}

func CEFRenderProcessHandler_on_uncaught_exception(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                   browser: UnsafeMutablePointer<cef_browser_t>?,
                                                   frame: UnsafeMutablePointer<cef_frame_t>?,
                                                   context: UnsafeMutablePointer<cef_v8context_t>?,
                                                   exception: UnsafeMutablePointer<cef_v8exception_t>?,
                                                   trace: UnsafeMutablePointer<cef_v8stack_trace_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onUncaughtException(browser: CEFBrowser.fromCEF(browser)!,
                            frame: CEFFrame.fromCEF(frame)!,
                            exception: CEFV8Exception.fromCEF(exception)!,
                            stackTrace: CEFV8StackTrace.fromCEF(trace)!)
}

func CEFRenderProcessHandler_on_focused_node_changed(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                     browser: UnsafeMutablePointer<cef_browser_t>?,
                                                     frame: UnsafeMutablePointer<cef_frame_t>?,
                                                     node: UnsafeMutablePointer<cef_domnode_t>?) {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onFocusedNodeChanged(browser: CEFBrowser.fromCEF(browser)!,
                             frame: CEFFrame.fromCEF(frame),
                             node: CEFDOMNode.fromCEF(node))
}

func CEFRenderProcessHandler_on_process_message_received(ptr: UnsafeMutablePointer<cef_render_process_handler_t>?,
                                                         browser: UnsafeMutablePointer<cef_browser_t>?,
                                                         processID: cef_process_id_t,
                                                         message:UnsafeMutablePointer<cef_process_message_t>?) -> Int32 {
    guard let obj = CEFRenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onProcessMessageReceived(browser: CEFBrowser.fromCEF(browser)!,
                                              processID: CEFProcessID.fromCEF(processID),
                                              message: CEFProcessMessage.fromCEF(message)!)
    return action == .consume ? 1 : 0
}

