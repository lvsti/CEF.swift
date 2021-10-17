//
//  CEFFrameHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_frame_handler.h.
//

import Foundation

extension cef_frame_handler_t: CEFObject {}

typealias CEFFrameHandlerMarshaller = CEFMarshaller<CEFFrameHandler, cef_frame_handler_t>

extension CEFFrameHandler {
    func toCEF() -> UnsafeMutablePointer<cef_frame_handler_t> {
        return CEFFrameHandlerMarshaller.pass(self)
    }
}

extension cef_frame_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_frame_created = CEFFrameHandler_on_frame_created
        on_frame_attached = CEFFrameHandler_on_frame_attached
        on_frame_detached = CEFFrameHandler_on_frame_detached
        on_main_frame_changed = CEFFrameHandler_on_main_frame_changed
    }
}
