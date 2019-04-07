//
//  CEFAudioHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 04. 07..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

private struct StreamDescriptor {
    let id: Int
    let channelCount: Int
}

private var streamDescriptors: [Int: StreamDescriptor] = [:]
private var streamDescriptorLock = SpinLock()

func CEFAudioHandler_on_audio_stream_started(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                             browser: UnsafeMutablePointer<cef_browser_t>?,
                                             audioStreamID: Int32,
                                             channelCount: Int32,
                                             channelLayout: cef_channel_layout_t,
                                             sampleRate: Int32,
                                             framesPerBuffer: Int32) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    let sd = StreamDescriptor(id: Int(audioStreamID), channelCount: Int(channelCount))
    streamDescriptorLock.lock()
    streamDescriptors[sd.id] = sd
    streamDescriptorLock.unlock()
    
    obj.onAudioStreamStarted(browser: CEFBrowser.fromCEF(browser)!,
                             audioStreamID: Int(audioStreamID),
                             channelCount: Int(channelCount),
                             channelLayout: CEFChannelLayout.fromCEF(channelLayout),
                             sampleRate: Int(sampleRate),
                             framesPerBuffer: Int(framesPerBuffer))
}

func CEFAudioHandler_on_audio_stream_packet(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            audioStreamID: Int32,
                                            packetData: UnsafeMutablePointer<UnsafePointer<Float>?>?,
                                            frameCount: Int32,
                                            pts: Int64) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    streamDescriptorLock.lock()
    guard let sd = streamDescriptors[Int(audioStreamID)] else {
        streamDescriptorLock.unlock()
        return
    }
    streamDescriptorLock.unlock()

    var data: [Data] = []
    for ch in 0..<sd.channelCount {
        guard let channelDataPtr = packetData?.advanced(by: ch).pointee else {
            data.append(Data())
            continue
        }
        let channelData = Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: channelDataPtr),
                               count: Int(frameCount),
                               deallocator: .none)
        data.append(channelData)
    }
    
    obj.onAudioStreamPacket(browser: CEFBrowser.fromCEF(browser)!,
                            audioStreamID: Int(audioStreamID),
                            data: data,
                            frameCount: Int(frameCount),
                            presentationTimestamp: CEFAudioPresentationTimestamp(pts))
}

func CEFAudioHandler_on_audio_stream_stopped(ptr: UnsafeMutablePointer<cef_audio_handler_t>?,
                                             browser: UnsafeMutablePointer<cef_browser_t>?,
                                             audioStreamID: Int32) {
    guard let obj = CEFAudioHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAudioStreamStopped(browser: CEFBrowser.fromCEF(browser)!,
                             audioStreamID: Int(audioStreamID))
    
    streamDescriptorLock.lock()
    streamDescriptors.removeValue(forKey: Int(audioStreamID))
    streamDescriptorLock.unlock()
}
