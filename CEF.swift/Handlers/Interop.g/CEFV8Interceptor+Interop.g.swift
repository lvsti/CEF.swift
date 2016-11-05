//
//  CEFV8Interceptor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8interceptor_t: CEFObject {}

typealias CEFV8InterceptorMarshaller = CEFMarshaller<CEFV8Interceptor, cef_v8interceptor_t>

extension CEFV8Interceptor {
    func toCEF() -> UnsafeMutablePointer<cef_v8interceptor_t> {
        return CEFV8InterceptorMarshaller.pass(self)
    }
}

extension cef_v8interceptor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_byname = CEFV8Interceptor_get_byname
        get_byindex = CEFV8Interceptor_get_byindex
        set_byname = CEFV8Interceptor_set_byname
        set_byindex = CEFV8Interceptor_set_byindex
    }
}
