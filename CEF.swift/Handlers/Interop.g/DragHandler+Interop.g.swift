//
//  DragHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_drag_handler.h.
//

import Foundation

extension cef_drag_handler_t: CEFObject {}

typealias DragHandlerMarshaller = Marshaller<DragHandler, cef_drag_handler_t>

extension DragHandler {
    func toCEF() -> UnsafeMutablePointer<cef_drag_handler_t> {
        return DragHandlerMarshaller.pass(self)
    }
}

extension cef_drag_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_drag_enter = DragHandler_on_drag_enter
        on_draggable_regions_changed = DragHandler_on_draggable_regions_changed
    }
}
