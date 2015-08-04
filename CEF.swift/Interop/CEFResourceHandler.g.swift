//
//  CEFResourceHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_resource_handler_t: CEFObject {
}

typealias CEFResourceHandlerMarshaller = CEFMarshaller<CEFResourceHandler, cef_resource_handler_t>

extension CEFResourceHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_handler_t> {
        return CEFResourceHandlerMarshaller.pass(self)
    }
}

extension cef_resource_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        process_request = CEFResourceHandler_processRequest
        get_response_headers = CEFResourceHandler_getResponseHeaders
        read_response = CEFResourceHandler_readResponse
        can_get_cookie = CEFResourceHandler_canGetCookie
        can_set_cookie = CEFResourceHandler_canSetCookie
        cancel = CEFResourceHandler_cancel
    }
}

func CEFResourceHandler_processRequest(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                       request: UnsafeMutablePointer<cef_request_t>,
                                       callback: UnsafeMutablePointer<cef_callback_t>) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.processRequest(CEFRequest.fromCEF(request)!, callback: CEFCallback.fromCEF(callback)!) ? 1 : 0
}

func CEFResourceHandler_getResponseHeaders(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                           response: UnsafeMutablePointer<cef_response_t>,
                                           responseLength: UnsafeMutablePointer<int64>,
                                           redirectURL: UnsafeMutablePointer<cef_string_t>) {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return
    }

    var length: Int64? = nil
    var url: NSURL? = nil
    obj.getResponseHeaders(CEFResponse.fromCEF(response)!, responseLength: &length, redirectURL: &url)
    
    if let length = length {
        responseLength.memory = length
    }
    
    if let url = url {
        CEFStringSetFromSwiftString(url.absoluteString, cefString: redirectURL)
    }
}

func CEFResourceHandler_readResponse(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                     buffer: UnsafeMutablePointer<Void>,
                                     bufferLength: Int32,
                                     actualLength: UnsafeMutablePointer<Int32>,
                                     callback: UnsafeMutablePointer<cef_callback_t>) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var length: Int = 0
    let retval = obj.readResponse(buffer,
                                  bufferLength: Int(bufferLength),
                                  actualLength: &length,
                                  callback: CEFCallback.fromCEF(callback)!)
    
    actualLength.memory = Int32(length)
    return retval ? 1 : 0
}

func CEFResourceHandler_canGetCookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                     cookie: UnsafePointer<cef_cookie_t>) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canGetCookie(CEFCookie.fromCEF(cookie.memory)) ? 1 : 0
}

func CEFResourceHandler_canSetCookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                     cookie: UnsafePointer<cef_cookie_t>) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canSetCookie(CEFCookie.fromCEF(cookie.memory)) ? 1 : 0
}

func CEFResourceHandler_cancel(ptr: UnsafeMutablePointer<cef_resource_handler_t>) {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return
    }

    obj.cancel()
}
