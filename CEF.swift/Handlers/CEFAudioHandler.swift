//
//  CEFAudioHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 04. 07..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

/// milliseconds since the Unix Epoch
public typealias CEFAudioPresentationTimestamp = UInt64

/// Implement this interface to handle audio events
/// All methods will be called on the UI thread
/// CEF name: `CefAudioHandler`
public protocol CEFAudioHandler {
    /// Called when the stream identified by |audio_stream_id| has started.
    /// |audio_stream_id| will uniquely identify the stream across all future
    /// CefAudioHandler callbacks. OnAudioSteamStopped will always be called after
    /// OnAudioStreamStarted; both methods may be called multiple times for the
    /// same stream. |channels| is the number of channels, |channel_layout| is the
    /// layout of the channels and |sample_rate| is the stream sample rate.
    /// |frames_per_buffer| is the maximum number of frames that will occur in the
    /// PCM packet passed to OnAudioStreamPacket.
    /// CEF name: `OnAudioStreamStarted`
    func onAudioStreamStarted(browser: CEFBrowser,
                              audioStreamID: Int,
                              channelCount: Int,
                              channelLayout: CEFChannelLayout,
                              sampleRate: Int,
                              framesPerBuffer: Int)

    /// Called when a PCM packet is received for the stream identified by
    /// |audio_stream_id|. |data| is an array representing the raw PCM data as a
    /// floating point type, i.e. 4-byte value(s). |frames| is the number of frames
    /// in the PCM packet. |pts| is the presentation timestamp (in milliseconds
    /// since the Unix Epoch) and represents the time at which the decompressed
    /// packet should be presented to the user. Based on |frames| and the
    /// |channel_layout| value passed to OnAudioStreamStarted you can calculate the
    /// size of the |data| array in bytes.
    /// CEF name: `OnAudioStreamPacket`
    func onAudioStreamPacket(browser: CEFBrowser,
                             audioStreamID: Int,
                             data: [Data],
                             frameCount: Int,
                             presentationTimestamp: CEFAudioPresentationTimestamp)

    /// Called when the stream identified by |audio_stream_id| has stopped.
    /// OnAudioSteamStopped will always be called after OnAudioStreamStarted; both
    /// methods may be called multiple times for the same stream.
    /// CEF name: `OnAudioStreamStopped`
    func onAudioStreamStopped(browser: CEFBrowser, audioStreamID: Int)
}

public extension CEFAudioHandler {
    func onAudioStreamStarted(browser: CEFBrowser,
                              audioStreamID: Int,
                              channelCount: Int,
                              channelLayout: CEFChannelLayout,
                              sampleRate: Int,
                              framesPerBuffer: Int) {
    }
    
    func onAudioStreamPacket(browser: CEFBrowser,
                             audioStreamID: Int,
                             data: [Data],
                             frameCount: Int,
                             presentationTimestamp: CEFAudioPresentationTimestamp) {
    }
    
    func onAudioStreamStopped(browser: CEFBrowser, audioStreamID: Int) {
    }

}
