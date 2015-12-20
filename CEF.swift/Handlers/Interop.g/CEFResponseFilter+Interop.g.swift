//
//  CEFResponseFilter+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_response_filter.h.
//

import Foundation

extension cef_response_filter_t: CEFObject {}

typealias CEFResponseFilterMarshaller = CEFMarshaller<CEFResponseFilter, cef_response_filter_t>

extension CEFResponseFilter {
    func toCEF() -> UnsafeMutablePointer<cef_response_filter_t> {
        return CEFResponseFilterMarshaller.pass(self)
    }
}

extension cef_response_filter_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        init_filter = CEFResponseFilter_init_filter
        filter = CEFResponseFilter_filter
    }
}
