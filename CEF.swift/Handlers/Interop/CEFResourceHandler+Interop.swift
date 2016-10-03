//
//  CEFResourceHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResourceHandler_process_request(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                                        request: UnsafeMutablePointer<cef_request_t>?,
                                        callback: UnsafeMutablePointer<cef_callback_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onProcessRequest(request: CEFRequest.fromCEF(request)!, callback: CEFCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFResourceHandler_get_response_headers(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                                             response: UnsafeMutablePointer<cef_response_t>?,
                                             responseLength: UnsafeMutablePointer<int64>?,
                                             redirectURL: UnsafeMutablePointer<cef_string_t>?) {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return
    }

    let action = obj.onGetResponseHeaders(response: CEFResponse.fromCEF(response)!)
    
    switch action {
    case .continueWithResponseLength(let length):
        responseLength!.pointee = int64(length)
    case .continueWithUnknownResponseLength:
        responseLength!.pointee = -1
    case .redirect(let url):
        CEFStringSetFromSwiftString(url.absoluteString!, cefStringPtr: redirectURL!)
    default:
        break
    }
    
}

func CEFResourceHandler_read_response(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                                      buffer: UnsafeMutableRawPointer?,
                                      bufferLength: Int32,
                                      actualLength: UnsafeMutablePointer<Int32>?,
                                      callback: UnsafeMutablePointer<cef_callback_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onReadResponse(buffer: buffer!,
                                    bufferLength: Int(bufferLength),
                                    callback: CEFCallback.fromCEF(callback)!)
                                        
    if case .read(let length) = action {
        actualLength!.pointee = Int32(length)
    }
    
    return action == .read || action == .readAsync ? 1 : 0
}

func CEFResourceHandler_can_get_cookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                                       cookie: UnsafePointer<cef_cookie_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canGetCookie(cookie: CEFCookie.fromCEF(cookie!.pointee)) ? 1 : 0
}

func CEFResourceHandler_can_set_cookie(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                                       cookie: UnsafePointer<cef_cookie_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 1
    }

    return obj.canSetCookie(cookie: CEFCookie.fromCEF(cookie!.pointee)) ? 1 : 0
}

func CEFResourceHandler_cancel(ptr: UnsafeMutablePointer<cef_resource_handler_t>?) {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onRequestCanceled()
}
