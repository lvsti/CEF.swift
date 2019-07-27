//
//  CEFResourceHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResourceHandler_open(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                             request: UnsafeMutablePointer<cef_request_t>?,
                             shouldHandle: UnsafeMutablePointer<Int32>?,
                             callback: UnsafeMutablePointer<cef_callback_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onOpenResponseStream(request: CEFRequest.fromCEF(request)!,
                                          callback: CEFCallback.fromCEF(callback)!)
    
    switch action {
    case .handle:
        shouldHandle?.pointee = 1
        return 1
    case .handleAsync:
        shouldHandle?.pointee = 0
        return 1
    case .cancel:
        shouldHandle?.pointee = 1
        return 0
    }
}

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
                                             responseLength: UnsafeMutablePointer<Int64>?,
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
        CEFStringSetFromSwiftString(url.absoluteString, cefStringPtr: redirectURL!)
    default:
        break
    }
    
}

func CEFResourceHandler_skip(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                             bytesToSkip: Int64,
                             bytesSkipped: UnsafeMutablePointer<Int64>?,
                             callback: UnsafeMutablePointer<cef_resource_skip_callback_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onSkipResponseData(skipLength: bytesToSkip,
                                        callback: CEFResourceSkipCallback.fromCEF(callback)!)
    switch action {
    case .skip(let actualSkipped):
        bytesSkipped?.pointee = actualSkipped
        return 1
    case .skipAsync:
        bytesSkipped?.pointee = 0
        return 1
    case .failure(let error):
        bytesSkipped?.pointee = Int64(error.rawValue)
        return 0
    }
}

func CEFResourceHandler_read(ptr: UnsafeMutablePointer<cef_resource_handler_t>?,
                             buffer: UnsafeMutableRawPointer?,
                             bufferLength: Int32,
                             actualLength: UnsafeMutablePointer<Int32>?,
                             callback: UnsafeMutablePointer<cef_resource_read_callback_t>?) -> Int32 {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onReadResponseData(buffer: buffer!,
                                        bufferLength: Int(bufferLength),
                                        callback: CEFResourceReadCallback.fromCEF(callback)!)
    
    switch action {
    case .read(let length):
        actualLength?.pointee = Int32(length)
        return 1
    case .readAsync:
        actualLength?.pointee = 0
        return 1
    case .complete:
        actualLength?.pointee = 0
        return 0
    case .failure(let error):
        actualLength?.pointee = error.rawValue
        return 0
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
    
    switch action {
    case .read(let length):
        actualLength!.pointee = Int32(length)
        return 1
    case .readAsync:
        actualLength!.pointee = 0
        return 1
    case .complete:
        return 0
    }
}

func CEFResourceHandler_cancel(ptr: UnsafeMutablePointer<cef_resource_handler_t>?) {
    guard let obj = CEFResourceHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onRequestCanceled()
}
