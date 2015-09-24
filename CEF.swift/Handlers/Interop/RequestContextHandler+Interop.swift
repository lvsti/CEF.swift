//
//  RequestContextHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func RequestContextHandler_get_cookie_manager(ptr: UnsafeMutablePointer<cef_request_context_handler_t>) -> UnsafeMutablePointer<cef_cookie_manager_t> {
    guard let obj = RequestContextHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let manager = obj.cookieManager {
        return manager.toCEF()
    }
    
    return nil
}

