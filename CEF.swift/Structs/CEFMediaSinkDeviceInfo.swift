//
//  CEFMediaSinkDeviceInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 07..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Device information for a MediaSink object.
/// CEF name: `CefMediaSinkDeviceInfo`
public struct CEFMediaSinkDeviceInfo {
    public let ipAddress: String
    public let port: UInt16
    public let modelName: String
}

extension CEFMediaSinkDeviceInfo {
    static func fromCEF(_ value: cef_media_sink_device_info_t) -> CEFMediaSinkDeviceInfo {
        return CEFMediaSinkDeviceInfo(ipAddress: CEFStringToSwiftString(value.ip_address),
                                      port: UInt16(value.port),
                                      modelName: CEFStringToSwiftString(value.model_name))
    }
}
