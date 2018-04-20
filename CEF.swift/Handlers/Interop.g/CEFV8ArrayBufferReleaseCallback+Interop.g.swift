//
//  CEFV8ArrayBufferReleaseCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8array_buffer_release_callback_t: CEFObject {}

typealias CEFV8ArrayBufferReleaseCallbackMarshaller = CEFMarshaller<CEFV8ArrayBufferReleaseCallback, cef_v8array_buffer_release_callback_t>

extension CEFV8ArrayBufferReleaseCallback {
    func toCEF() -> UnsafeMutablePointer<cef_v8array_buffer_release_callback_t> {
        return CEFV8ArrayBufferReleaseCallbackMarshaller.pass(self)
    }
}

extension cef_v8array_buffer_release_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        release_buffer = CEFV8ArrayBufferReleaseCallback_release_buffer
    }
}
