//
//  CEFRequestContextHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRequestContextHandler_get_cookie_manager(ptr: UnsafeMutablePointer<cef_request_context_handler_t>) -> UnsafeMutablePointer<cef_cookie_manager_t> {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let manager = obj.getCookieManager() {
        return manager.toCEF()
    }
    
    return nil
}

