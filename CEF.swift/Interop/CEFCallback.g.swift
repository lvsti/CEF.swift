//
//  CEFCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_callback_t: CEFObject {
}

extension cef_callback_t: CEFWrappable {
    typealias WrapperType = CEFCallback
}

typealias CEFCallbackMarshaller = CEFMarshaller<CEFCallback, cef_callback_t>

extension CEFCallback {
    func toCEF() -> UnsafeMutablePointer<cef_callback_t> {
        return CEFCallbackMarshaller.pass(self)
    }
}

extension cef_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        cont = CEFCallback_continue
        cancel = CEFCallback_cancel
    }
}

func CEFCallback_continue(ptr: UnsafeMutablePointer<cef_callback_t>) {
    guard let obj = CEFCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.doContinue()
}

func CEFCallback_cancel(ptr: UnsafeMutablePointer<cef_callback_t>) {
    guard let obj = CEFCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.cancel()
}
