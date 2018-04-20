//
//  CEFV8ArrayBufferReleaseCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 04. 20..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFV8ArrayBufferReleaseCallback_release_buffer(ptr: UnsafeMutablePointer<cef_v8array_buffer_release_callback_t>?,
                                                    buffer: UnsafeMutableRawPointer?) {
    guard let obj = CEFV8ArrayBufferReleaseCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.releaseBuffer(buffer)
}
