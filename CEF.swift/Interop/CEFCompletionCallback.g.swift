//
//  CEFCompletionCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_completion_callback_t: CEFObject {
}

typealias CEFCompletionCallbackMarshaller = CEFMarshaller<CEFCompletionCallback, cef_completion_callback_t>

extension CEFCompletionCallback {
    func toCEF() -> UnsafeMutablePointer<cef_completion_callback_t> {
        return CEFCompletionCallbackMarshaller.pass(self)
    }
}

extension cef_completion_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CEFCompletionCallback_onComplete
    }
}

func CEFCompletionCallback_onComplete(ptr: UnsafeMutablePointer<cef_completion_callback_t>) {
    guard let obj = CEFCompletionCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onComplete()
}

