//
//  CEFEndTracingCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFEndTracingCallback_on_end_tracing_complete(ptr: UnsafeMutablePointer<cef_end_tracing_callback_t>?,
                                                   filePath: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFEndTracingCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onEndTracingComplete(traceFilePath: CEFStringToSwiftString(filePath!.pointee))
}

