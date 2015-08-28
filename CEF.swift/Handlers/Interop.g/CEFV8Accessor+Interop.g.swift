//
//  CEFV8Accessor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8accessor_t: CEFObject {}

typealias CEFV8AccessorMarshaller = CEFMarshaller<CEFV8Accessor, cef_v8accessor_t>

extension CEFV8Accessor {
    func toCEF() -> UnsafeMutablePointer<cef_v8accessor_t> {
        return CEFV8AccessorMarshaller.pass(self)
    }
}

extension cef_v8accessor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get = CEFV8Accessor_get
        set = CEFV8Accessor_set
    }
}
