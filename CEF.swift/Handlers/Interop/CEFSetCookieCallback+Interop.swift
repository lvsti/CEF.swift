//
//  CEFSetCookieCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFSetCookieCallback_on_complete(ptr: UnsafeMutablePointer<cef_set_cookie_callback_t>,
                                      success: Int32) {
    guard let obj = CEFSetCookieCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onComplete(success: success != 0)
}
