//
//  CEFAudioHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 07..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFGetAudioParametersAction {
    case `continue`
    case cancel
}

/// Implement this interface to handle audio events.
/// CEF name: `CefAudioHandler`
public protocol CEFAudioHandler {

    /// Called on the UI thread to allow configuration of audio stream parameters.
    /// Return true to proceed with audio stream capture, or false to cancel it.
    /// All members of |params| can optionally be configured here, but they are
    /// also pre-filled with some sensible defaults.
    /// CEF name: `GetAudioParameters`
    func getAudioParameters(browser: CEFBrowser, parameters: inout CEFAudioParameters) -> CEFGetAudioParametersAction
    
    // Called on a browser audio capture thread when the browser starts
    // streaming audio. OnAudioSteamStopped will always be called after
    // OnAudioStreamStarted; both methods may be called multiple times
    // for the same browser. |params| contains the audio parameters like
    // sample rate and channel layout. |channels| is the number of channels.
    /// CEF name: `OnAudioStreamStarted`
    func onAudioStreamStarted(browser: CEFBrowser, parameters: CEFAudioParameters, channelCount: Int)
    
    /// Called on the audio stream thread when a PCM packet is received for the
    /// stream. |data| is an array representing the raw PCM data as a floating
    /// point type, i.e. 4-byte value(s). |frames| is the number of frames in the
    /// PCM packet. |pts| is the presentation timestamp (in milliseconds since the
    /// Unix Epoch) and represents the time at which the decompressed packet should
    /// be presented to the user. Based on |frames| and the |channel_layout| value
    /// passed to OnAudioStreamStarted you can calculate the size of the |data|
    /// array in bytes.
    /// CEF name: `OnAudioStreamPacket`
    func onAudioStreamPacket(browser: CEFBrowser, dataForChannel: (Int) -> Data, frameCount: Int, presentationTimestamp: Int64)
    
    /// Called on the UI thread when the stream has stopped. OnAudioSteamStopped
    /// will always be called after OnAudioStreamStarted; both methods may be
    /// called multiple times for the same stream.
    /// CEF name: `OnAudioStreamStopped`
    func onAudioStreamStopped(browser: CEFBrowser)
    
    /// Called on the UI or audio stream thread when an error occurred. During the
    /// stream creation phase this callback will be called on the UI thread while
    /// in the capturing phase it will be called on the audio stream thread. The
    /// stream will be stopped immediately.
    /// CEF name: `OnAudioStreamError`
    func onAudioStreamError(browser: CEFBrowser, message: String)
}
