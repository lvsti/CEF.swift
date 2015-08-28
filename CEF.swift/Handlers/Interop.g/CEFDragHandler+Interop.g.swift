//
//  CEFDragHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_drag_handler.h.
//

import Foundation

extension cef_drag_handler_t: CEFObject {}

typealias CEFDragHandlerMarshaller = CEFMarshaller<CEFDragHandler, cef_drag_handler_t>

extension CEFDragHandler {
    func toCEF() -> UnsafeMutablePointer<cef_drag_handler_t> {
        return CEFDragHandlerMarshaller.pass(self)
    }
}

extension cef_drag_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_drag_enter = CEFDragHandler_on_drag_enter
        on_draggable_regions_changed = CEFDragHandler_on_draggable_regions_changed
    }
}
