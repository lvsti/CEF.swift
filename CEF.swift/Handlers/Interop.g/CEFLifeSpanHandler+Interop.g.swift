//
//  CEFLifeSpanHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_life_span_handler.h.
//

import Foundation

extension cef_life_span_handler_t: CEFObject {}

typealias CEFLifeSpanHandlerMarshaller = CEFMarshaller<CEFLifeSpanHandler, cef_life_span_handler_t>

extension CEFLifeSpanHandler {
    func toCEF() -> UnsafeMutablePointer<cef_life_span_handler_t> {
        return CEFLifeSpanHandlerMarshaller.pass(self)
    }
}

extension cef_life_span_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_popup = CEFLifeSpanHandler_on_before_popup
        on_after_created = CEFLifeSpanHandler_on_after_created
        do_close = CEFLifeSpanHandler_do_close
        on_before_close = CEFLifeSpanHandler_on_before_close
    }
}
