//
//  CEFBrowserProcessHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser_process_handler.h.
//

import Foundation

extension cef_browser_process_handler_t: CEFObject {}

typealias CEFBrowserProcessHandlerMarshaller = CEFMarshaller<CEFBrowserProcessHandler, cef_browser_process_handler_t>

extension CEFBrowserProcessHandler {
    func toCEF() -> UnsafeMutablePointer<cef_browser_process_handler_t> {
        return CEFBrowserProcessHandlerMarshaller.pass(self)
    }
}

extension cef_browser_process_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_context_initialized = CEFBrowserProcessHandler_on_context_initialized
        on_before_child_process_launch = CEFBrowserProcessHandler_on_before_child_process_launch
        on_schedule_message_pump_work = CEFBrowserProcessHandler_on_schedule_message_pump_work
        get_default_client = CEFBrowserProcessHandler_get_default_client
    }
}
