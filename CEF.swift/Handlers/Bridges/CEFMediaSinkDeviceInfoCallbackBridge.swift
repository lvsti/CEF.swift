//
//  CEFMediaSinkDeviceInfoCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefMediaSink::GetDeviceInfo. The methods of this
/// class will be called on the browser process UI thread.
public typealias CEFMediaSinkDeviceInfoCallbackOnMediaSinkDeviceInfoBlock =
    (_ deviceInfo: CEFMediaSinkDeviceInfo) -> Void

class CEFMediaSinkDeviceInfoCallbackBridge: CEFMediaSinkDeviceInfoCallback {
    let block: CEFMediaSinkDeviceInfoCallbackOnMediaSinkDeviceInfoBlock
    
    init(block: @escaping CEFMediaSinkDeviceInfoCallbackOnMediaSinkDeviceInfoBlock) {
        self.block = block
    }
    
    func onMediaSinkDeviceInfo(_ deviceInfo: CEFMediaSinkDeviceInfo) {
        block(deviceInfo)
    }
}
