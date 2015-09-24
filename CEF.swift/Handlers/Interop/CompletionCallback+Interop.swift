//
//  CompletionCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CompletionCallback_on_complete(ptr: UnsafeMutablePointer<cef_completion_callback_t>) {
    guard let obj = CompletionCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onComplete()
}

