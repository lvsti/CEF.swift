//
//  CEFRenderHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_render_handler.h.
//

import Foundation

extension cef_render_handler_t: CEFObject {}

typealias CEFRenderHandlerMarshaller = CEFMarshaller<CEFRenderHandler, cef_render_handler_t>

extension CEFRenderHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_handler_t> {
        return CEFRenderHandlerMarshaller.pass(self)
    }
}

extension cef_render_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_accessibility_handler = CEFRenderHandler_get_accessibility_handler
        get_root_screen_rect = CEFRenderHandler_get_root_screen_rect
        get_view_rect = CEFRenderHandler_get_view_rect
        get_screen_point = CEFRenderHandler_get_screen_point
        get_screen_info = CEFRenderHandler_get_screen_info
        on_popup_show = CEFRenderHandler_on_popup_show
        on_popup_size = CEFRenderHandler_on_popup_size
        on_paint = CEFRenderHandler_on_paint
        on_accelerated_paint = CEFRenderHandler_on_accelerated_paint
        on_cursor_change = CEFRenderHandler_on_cursor_change
        start_dragging = CEFRenderHandler_start_dragging
        update_drag_cursor = CEFRenderHandler_update_drag_cursor
        on_scroll_offset_changed = CEFRenderHandler_on_scroll_offset_changed
        on_ime_composition_range_changed = CEFRenderHandler_on_ime_composition_range_changed
        on_text_selection_changed = CEFRenderHandler_on_text_selection_changed
        on_virtual_keyboard_requested = CEFRenderHandler_on_virtual_keyboard_requested
    }
}
