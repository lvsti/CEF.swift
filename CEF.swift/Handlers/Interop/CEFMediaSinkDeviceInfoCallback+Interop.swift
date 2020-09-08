//
//  CEFMediaSinkDeviceInfoCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFMediaSinkDeviceInfoCallback_on_media_sink_device_info(ptr: UnsafeMutablePointer<cef_media_sink_device_info_callback_t>?,
                                                              info: UnsafePointer<cef_media_sink_device_info_t>?) {
    guard let obj = CEFMediaSinkDeviceInfoCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onMediaSinkDeviceInfo(CEFMediaSinkDeviceInfo.fromCEF(info!.pointee))
}
