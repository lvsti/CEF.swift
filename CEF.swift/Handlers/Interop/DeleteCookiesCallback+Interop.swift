//
//  DeleteCookiesCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func DeleteCookiesCallback_on_complete(ptr: UnsafeMutablePointer<cef_delete_cookies_callback_t>,
                                       deletedCount: Int32) {
    guard let obj = DeleteCookiesCallbackMarshaller.get(ptr) else {
        return
    }
    
    let count: Int? = deletedCount >= 0 ? Int(deletedCount) : nil
    obj.onComplete(count)
}
