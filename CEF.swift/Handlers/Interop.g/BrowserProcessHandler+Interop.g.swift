//
//  BrowserProcessHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser_process_handler.h.
//

import Foundation

extension cef_browser_process_handler_t: CEFObject {}

typealias BrowserProcessHandlerMarshaller = Marshaller<BrowserProcessHandler, cef_browser_process_handler_t>

extension BrowserProcessHandler {
    func toCEF() -> UnsafeMutablePointer<cef_browser_process_handler_t> {
        return BrowserProcessHandlerMarshaller.pass(self)
    }
}

extension cef_browser_process_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_context_initialized = BrowserProcessHandler_on_context_initialized
        on_before_child_process_launch = BrowserProcessHandler_on_before_child_process_launch
        on_render_process_thread_created = BrowserProcessHandler_on_render_process_thread_created
        get_print_handler = BrowserProcessHandler_get_print_handler
    }
}
