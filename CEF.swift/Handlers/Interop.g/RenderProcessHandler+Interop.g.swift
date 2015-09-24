//
//  RenderProcessHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_render_process_handler.h.
//

import Foundation

extension cef_render_process_handler_t: CEFObject {}

typealias RenderProcessHandlerMarshaller = Marshaller<RenderProcessHandler, cef_render_process_handler_t>

extension RenderProcessHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_process_handler_t> {
        return RenderProcessHandlerMarshaller.pass(self)
    }
}

extension cef_render_process_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_render_thread_created = RenderProcessHandler_on_render_thread_created
        on_web_kit_initialized = RenderProcessHandler_on_web_kit_initialized
        on_browser_created = RenderProcessHandler_on_browser_created
        on_browser_destroyed = RenderProcessHandler_on_browser_destroyed
        get_load_handler = RenderProcessHandler_get_load_handler
        on_before_navigation = RenderProcessHandler_on_before_navigation
        on_context_created = RenderProcessHandler_on_context_created
        on_context_released = RenderProcessHandler_on_context_released
        on_uncaught_exception = RenderProcessHandler_on_uncaught_exception
        on_focused_node_changed = RenderProcessHandler_on_focused_node_changed
        on_process_message_received = RenderProcessHandler_on_process_message_received
    }
}
