//
//  CEFAudioParameters.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 07..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing the audio parameters for setting up the audio handler.
/// CEF name: `CefAudioParameters`
public struct CEFAudioParameters {
    /// Layout of the audio channels
    /// CEF name: `channel_layout`
    public let channelLayout: CEFChannelLayout
    
    /// Sample rate
    /// CEF name: `sample_rate`
    public let sampleRate: Int
    
    /// Number of frames per buffer
    /// CEF name: `frames_per_buffer`
    public let framesPerBuffer: Int
}

extension CEFAudioParameters {
    func toCEF() -> cef_audio_parameters_t {
        var cefStruct = cef_audio_parameters_t()
        cefStruct.channel_layout = channelLayout.toCEF()
        cefStruct.sample_rate = Int32(sampleRate)
        cefStruct.frames_per_buffer = Int32(framesPerBuffer)
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_audio_parameters_t) -> CEFAudioParameters {
        return CEFAudioParameters(channelLayout: CEFChannelLayout.fromCEF(value.channel_layout),
                                  sampleRate: Int(value.sample_rate),
                                  framesPerBuffer: Int(value.frames_per_buffer))
    }
}
