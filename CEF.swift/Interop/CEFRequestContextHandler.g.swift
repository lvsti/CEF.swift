//
//  CEFRequestContextHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_request_context_handler_t: CEFObject {
}

extension cef_request_context_handler_t: CEFWrappable {
    typealias WrapperType = CEFRequestContextHandler
}

typealias CEFRequestContextHandlerMarshaller = CEFMarshaller<CEFRequestContextHandler, cef_request_context_handler_t>

extension CEFRequestContextHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_context_handler_t> {
        return CEFRequestContextHandlerMarshaller.pass(self)
    }
}

extension cef_request_context_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_cookie_manager = CEFRequestContextHandler_getCookieManager
    }
}

func CEFRequestContextHandler_getCookieManager(ptr: UnsafeMutablePointer<cef_request_context_handler_t>) -> UnsafeMutablePointer<cef_cookie_manager_t> {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let manager = obj.getCookieManager() {
        return manager.toCEF()
    }
    
    return nil
}

