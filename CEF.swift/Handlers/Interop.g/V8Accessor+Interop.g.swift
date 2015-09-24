//
//  V8Accessor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8accessor_t: CEFObject {}

typealias V8AccessorMarshaller = Marshaller<V8Accessor, cef_v8accessor_t>

extension V8Accessor {
    func toCEF() -> UnsafeMutablePointer<cef_v8accessor_t> {
        return V8AccessorMarshaller.pass(self)
    }
}

extension cef_v8accessor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        get = V8Accessor_get
        set = V8Accessor_set
    }
}
