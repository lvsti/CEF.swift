//
//  CEFAudioHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_audio_handler.h.
//

import Foundation

extension cef_audio_handler_t: CEFObject {}

typealias CEFAudioHandlerMarshaller = CEFMarshaller<CEFAudioHandler, cef_audio_handler_t>

extension CEFAudioHandler {
    func toCEF() -> UnsafeMutablePointer<cef_audio_handler_t> {
        return CEFAudioHandlerMarshaller.pass(self)
    }
}

extension cef_audio_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_audio_parameters = CEFAudioHandler_get_audio_parameters
        on_audio_stream_started = CEFAudioHandler_on_audio_stream_started
        on_audio_stream_packet = CEFAudioHandler_on_audio_stream_packet
        on_audio_stream_stopped = CEFAudioHandler_on_audio_stream_stopped
        on_audio_stream_error = CEFAudioHandler_on_audio_stream_error
    }
}
