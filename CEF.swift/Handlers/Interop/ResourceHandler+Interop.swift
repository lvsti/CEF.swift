//
//  ResourceHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func ResourceHandler_process_request(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                     request: UnsafeMutablePointer<cef_request_t>,
                                     callback: UnsafeMutablePointer<cef_callback_t>) -> Int32 {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onProcessRequest(Request.fromCEF(request)!, callback: Callback.fromCEF(callback)!) ? 1 : 0
}

func ResourceHandler_get_response_headers(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                          response: UnsafeMutablePointer<cef_response_t>,
                                          responseLength: UnsafeMutablePointer<int64>,
                                          redirectURL: UnsafeMutablePointer<cef_string_t>) {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return
    }

    var length: Int64? = nil
    var url: NSURL? = nil
    obj.onGetResponseHeaders(Response.fromCEF(response)!, responseLength: &length, redirectURL: &url)
    
    if let length = length {
        responseLength.memory = length
    }
    
    if let url = url {
        CEFStringSetFromSwiftString(url.absoluteString, cefString: redirectURL)
    }
}

func ResourceHandler_read_response(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                   buffer: UnsafeMutablePointer<Void>,
                                   bufferLength: Int32,
                                   actualLength: UnsafeMutablePointer<Int32>,
                                   callback: UnsafeMutablePointer<cef_callback_t>) -> Int32 {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onReadResponse(buffer,
                                    bufferLength: Int(bufferLength),
                                    callback: Callback.fromCEF(callback)!)
                                        
    if case .Read(let length) = action {
        actualLength.memory = Int32(length)
    }
    
    return action ? 1 : 0
}

func ResourceHandler_can_get_cookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                    cookie: UnsafePointer<cef_cookie_t>) -> Int32 {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canGetCookie(Cookie.fromCEF(cookie.memory)) ? 1 : 0
}

func ResourceHandler_can_set_cookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>,
                                    cookie: UnsafePointer<cef_cookie_t>) -> Int32 {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canSetCookie(Cookie.fromCEF(cookie.memory)) ? 1 : 0
}

func ResourceHandler_cancel(ptr: UnsafeMutablePointer<cef_resource_handler_t>) {
    guard let obj = ResourceHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onRequestCanceled()
}
