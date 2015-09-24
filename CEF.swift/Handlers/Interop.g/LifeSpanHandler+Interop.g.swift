//
//  LifeSpanHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_life_span_handler.h.
//

import Foundation

extension cef_life_span_handler_t: CEFObject {}

typealias LifeSpanHandlerMarshaller = Marshaller<LifeSpanHandler, cef_life_span_handler_t>

extension LifeSpanHandler {
    func toCEF() -> UnsafeMutablePointer<cef_life_span_handler_t> {
        return LifeSpanHandlerMarshaller.pass(self)
    }
}

extension cef_life_span_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_popup = LifeSpanHandler_on_before_popup
        on_after_created = LifeSpanHandler_on_after_created
        run_modal = LifeSpanHandler_run_modal
        do_close = LifeSpanHandler_do_close
        on_before_close = LifeSpanHandler_on_before_close
    }
}
