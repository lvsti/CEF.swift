//
//  CEFEndTracingCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_end_tracing_callback_t: CEFObject {
}

typealias CEFEndTracingCallbackMarshaller = CEFMarshaller<CEFEndTracingCallback, cef_end_tracing_callback_t>

extension CEFEndTracingCallback {
    func toCEF() -> UnsafeMutablePointer<cef_end_tracing_callback_t> {
        return CEFEndTracingCallbackMarshaller.pass(self)
    }
}

extension cef_end_tracing_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_end_tracing_complete = CEFEndTracingCallback_onEndTracingComplete
    }
}

func CEFEndTracingCallback_onEndTracingComplete(ptr: UnsafeMutablePointer<cef_end_tracing_callback_t>,
                                                filePath: UnsafePointer<cef_string_t>) {
    guard let obj = CEFEndTracingCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onEndTracingComplete(CEFStringToSwiftString(filePath.memory))
}

