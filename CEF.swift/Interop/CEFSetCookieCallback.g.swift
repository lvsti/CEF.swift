//
//  CEFSetCookieCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_set_cookie_callback_t: CEFObject {
}

typealias CEFSetCookieCallbackMarshaller = CEFMarshaller<CEFSetCookieCallback, cef_set_cookie_callback_t>

extension CEFSetCookieCallback {
    func toCEF() -> UnsafeMutablePointer<cef_set_cookie_callback_t> {
        return CEFSetCookieCallbackMarshaller.pass(self)
    }
}

extension cef_set_cookie_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_complete = CEFSetCookieCallback_onComplete
    }
}

func CEFSetCookieCallback_onComplete(ptr: UnsafeMutablePointer<cef_set_cookie_callback_t>,
                                     success: Int32) {
    guard let obj = CEFSetCookieCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onComplete(success != 0)
}
