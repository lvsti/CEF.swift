//
//  CEFAudioHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFAudioHandler_get_audio_parameters(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                          browser: UnsafeMutablePointer<cef_browser_t>?,
                                          params: UnsafeMutablePointer<cef_audio_parameters_t>?) -> Int32 {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var parameters = CEFAudioParameters.fromCEF(params!.pointee)
    let action = obj.getAudioParameters(browser: CEFBrowser.fromCEF(browser)!,
                                        parameters: &parameters)
    params?.pointee = parameters.toCEF()
    return action == .continue ? 1 : 0
}

func CEFAudioHandler_on_audio_stream_started(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                             browser: UnsafeMutablePointer<cef_browser_t>?,
                                             params: UnsafePointer<cef_audio_parameters_t>?,
                                             channels: Int32) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAudioStreamStarted(browser: CEFBrowser.fromCEF(browser)!,
                             parameters: CEFAudioParameters.fromCEF(params!.pointee),
                             channelCount: Int(channels))
}

func CEFAudioHandler_on_audio_stream_packet(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            data: UnsafeMutablePointer<UnsafePointer<Float>?>?,
                                            frames: Int32,
                                            pts: Int64) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAudioStreamPacket(browser: CEFBrowser.fromCEF(browser)!,
                            dataForChannel: { Data(bytesNoCopy: data!.advanced(by: $0),
                                                   count: $0 * Int(frames) * MemoryLayout<Float>.size,
                                                   deallocator: .none) },
                            frameCount: Int(frames),
                            presentationTimestamp: pts)
}

func CEFAudioHandler_on_audio_stream_stopped(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                             browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAudioStreamStopped(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFAudioHandler_on_audio_stream_error(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           msg: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAudioStreamError(browser: CEFBrowser.fromCEF(browser)!,
                           message: CEFStringToSwiftString(msg!.pointee))
}

