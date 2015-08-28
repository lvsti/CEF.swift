//
//  CEFDeleteCookiesCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDeleteCookiesCallback_onComplete(ptr: UnsafeMutablePointer<cef_delete_cookies_callback_t>,
                                         deletedCount: Int32) {
    guard let obj = CEFDeleteCookiesCallbackMarshaller.get(ptr) else {
        return
    }
    
    let count: Int? = deletedCount >= 0 ? Int(deletedCount) : nil
    obj.onComplete(count)
}
