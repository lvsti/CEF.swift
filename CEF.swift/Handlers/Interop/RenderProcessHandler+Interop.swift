//
//  RenderProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func RenderProcessHandler_on_render_thread_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                   info: UnsafeMutablePointer<cef_list_value_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderThreadCreated(ListValue.fromCEF(info)!)
}

func RenderProcessHandler_on_web_kit_initialized(ptr: UnsafeMutablePointer<cef_render_process_handler_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onWebKitInitialized()
}

func RenderProcessHandler_on_browser_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                             browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserCreated(Browser.fromCEF(browser)!)
}

func RenderProcessHandler_on_browser_destroyed(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                               browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBrowserDestroyed(Browser.fromCEF(browser)!)
}

func RenderProcessHandler_get_load_handler(ptr: UnsafeMutablePointer<cef_render_process_handler_t>) -> UnsafeMutablePointer<cef_load_handler_t> {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.loadHandler {
        return handler.toCEF()
    }
    
    return nil
}

func RenderProcessHandler_on_before_navigation(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                               browser: UnsafeMutablePointer<cef_browser_t>,
                                               frame: UnsafeMutablePointer<cef_frame_t>,
                                               request: UnsafeMutablePointer<cef_request_t>,
                                               navType: cef_navigation_type_t,
                                               isRedirect: Int32) -> Int32 {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onBeforeNavigation(Browser.fromCEF(browser)!,
                                  frame: Frame.fromCEF(frame)!,
                                  request: Request.fromCEF(request)!,
                                  navigationType: NavigationType.fromCEF(navType),
                                  isRedirect: isRedirect != 0) ? 1 : 0
}

func RenderProcessHandler_on_context_created(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                             browser: UnsafeMutablePointer<cef_browser_t>,
                                             frame: UnsafeMutablePointer<cef_frame_t>,
                                             context: UnsafeMutablePointer<cef_v8context_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextCreated(Browser.fromCEF(browser)!,
                         frame: Frame.fromCEF(frame)!,
                         context: V8Context.fromCEF(context)!)
}

func RenderProcessHandler_on_context_released(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                              browser: UnsafeMutablePointer<cef_browser_t>,
                                              frame: UnsafeMutablePointer<cef_frame_t>,
                                              context: UnsafeMutablePointer<cef_v8context_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onContextReleased(Browser.fromCEF(browser)!,
                          frame: Frame.fromCEF(frame)!,
                          context: V8Context.fromCEF(context)!)
}

func RenderProcessHandler_on_uncaught_exception(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                browser: UnsafeMutablePointer<cef_browser_t>,
                                                frame: UnsafeMutablePointer<cef_frame_t>,
                                                context: UnsafeMutablePointer<cef_v8context_t>,
                                                exception: UnsafeMutablePointer<cef_v8exception_t>,
                                                trace: UnsafeMutablePointer<cef_v8stack_trace_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onUncaughtException(Browser.fromCEF(browser)!,
                            frame: Frame.fromCEF(frame)!,
                            context: V8Context.fromCEF(context)!,
                            exception: V8Exception.fromCEF(exception)!,
                            stackTrace: V8StackTrace.fromCEF(trace)!)
}

func RenderProcessHandler_on_focused_node_changed(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                                  frame: UnsafeMutablePointer<cef_frame_t>,
                                                  node: UnsafeMutablePointer<cef_domnode_t>) {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onFocusedNodeChanged(Browser.fromCEF(browser)!,
        frame: Frame.fromCEF(frame),
        node: DOMNode.fromCEF(node))
}

func RenderProcessHandler_on_process_message_received(ptr: UnsafeMutablePointer<cef_render_process_handler_t>,
                                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                                      processID: cef_process_id_t,
                                                      message:UnsafeMutablePointer<cef_process_message_t>) -> Int32 {
    guard let obj = RenderProcessHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onProcessMessageReceived(Browser.fromCEF(browser)!,
                                        processID: ProcessID.fromCEF(processID),
                                        message: ProcessMessage.fromCEF(message)!) ? 1 : 0
}

