//
//  RenderHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_render_handler.h.
//

import Foundation

extension cef_render_handler_t: CEFObject {}

typealias RenderHandlerMarshaller = Marshaller<RenderHandler, cef_render_handler_t>

extension RenderHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_handler_t> {
        return RenderHandlerMarshaller.pass(self)
    }
}

extension cef_render_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        get_root_screen_rect = RenderHandler_get_root_screen_rect
        get_view_rect = RenderHandler_get_view_rect
        get_screen_point = RenderHandler_get_screen_point
        get_screen_info = RenderHandler_get_screen_info
        on_popup_show = RenderHandler_on_popup_show
        on_popup_size = RenderHandler_on_popup_size
        on_paint = RenderHandler_on_paint
        on_cursor_change = RenderHandler_on_cursor_change
        start_dragging = RenderHandler_start_dragging
        update_drag_cursor = RenderHandler_update_drag_cursor
        on_scroll_offset_changed = RenderHandler_on_scroll_offset_changed
    }
}
