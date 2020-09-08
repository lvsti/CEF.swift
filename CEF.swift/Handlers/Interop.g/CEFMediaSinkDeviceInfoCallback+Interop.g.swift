//
//  CEFMediaSinkDeviceInfoCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_sink_device_info_callback_t: CEFObject {}

typealias CEFMediaSinkDeviceInfoCallbackMarshaller = CEFMarshaller<CEFMediaSinkDeviceInfoCallback, cef_media_sink_device_info_callback_t>

extension CEFMediaSinkDeviceInfoCallback {
    func toCEF() -> UnsafeMutablePointer<cef_media_sink_device_info_callback_t> {
        return CEFMediaSinkDeviceInfoCallbackMarshaller.pass(self)
    }
}

extension cef_media_sink_device_info_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_media_sink_device_info = CEFMediaSinkDeviceInfoCallback_on_media_sink_device_info
    }
}
