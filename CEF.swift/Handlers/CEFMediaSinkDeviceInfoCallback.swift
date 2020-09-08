//
//  CEFMediaSinkDeviceInfoCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefMediaSink::GetDeviceInfo. The methods of this
/// class will be called on the browser process UI thread.
/// CEF name: `CefMediaSinkDeviceInfoCallback`
public protocol CEFMediaSinkDeviceInfoCallback {
    
    /// Method that will be executed asyncronously once device information has been
    /// retrieved.
    /// CEF name: `OnMediaSinkDeviceInfo`
    func onMediaSinkDeviceInfo(_ deviceInfo: CEFMediaSinkDeviceInfo)
}

public extension CEFMediaSinkDeviceInfoCallback {
    
    func onMediaSinkDeviceInfo(_ deviceInfo: CEFMediaSinkDeviceInfo) {
    }
    
}
