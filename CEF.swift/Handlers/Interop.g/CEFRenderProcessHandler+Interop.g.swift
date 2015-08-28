//
//  CEFRenderProcessHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_render_process_handler.h.
//

import Foundation

extension cef_render_process_handler_t: CEFObject {}

typealias CEFRenderProcessHandlerMarshaller = CEFMarshaller<CEFRenderProcessHandler, cef_render_process_handler_t>

extension CEFRenderProcessHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_process_handler_t> {
        return CEFRenderProcessHandlerMarshaller.pass(self)
    }
}

extension cef_render_process_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_render_thread_created = CEFRenderProcessHandler_on_render_thread_created
        on_web_kit_initialized = CEFRenderProcessHandler_on_web_kit_initialized
        on_browser_created = CEFRenderProcessHandler_on_browser_created
        on_browser_destroyed = CEFRenderProcessHandler_on_browser_destroyed
        get_load_handler = CEFRenderProcessHandler_get_load_handler
        on_before_navigation = CEFRenderProcessHandler_on_before_navigation
        on_context_created = CEFRenderProcessHandler_on_context_created
        on_context_released = CEFRenderProcessHandler_on_context_released
        on_uncaught_exception = CEFRenderProcessHandler_on_uncaught_exception
        on_focused_node_changed = CEFRenderProcessHandler_on_focused_node_changed
        on_process_message_received = CEFRenderProcessHandler_on_process_message_received
    }
}
