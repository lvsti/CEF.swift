//
//  CEFURLRequestClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFURLRequestClient_on_request_complete(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>?,
                                             request: UnsafeMutablePointer<cef_urlrequest_t>?) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onRequestComplete(request: CEFURLRequest.fromCEF(request)!)
}

func CEFURLRequestClient_on_upload_progress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>?,
                                            request: UnsafeMutablePointer<cef_urlrequest_t>?,
                                            sent: Int64,
                                            total: Int64) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onUploadProgress(request: CEFURLRequest.fromCEF(request)!, sentCount: sent, totalCount: total)
}

func CEFURLRequestClient_on_download_progress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>?,
                                              request: UnsafeMutablePointer<cef_urlrequest_t>?,
                                              received: Int64,
                                              total: Int64) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadProgress(request: CEFURLRequest.fromCEF(request)!, receivedCount: received, totalCount: total)
}

func CEFURLRequestClient_on_download_data(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>?,
                                          request: UnsafeMutablePointer<cef_urlrequest_t>?,
                                          data: UnsafeRawPointer?,
                                          size: size_t) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadData(request: CEFURLRequest.fromCEF(request)!,
                       chunk: NSData(bytesNoCopy: UnsafeMutableRawPointer(mutating: data!), length: size, freeWhenDone: false))
}

func CEFURLRequestClient_get_auth_credentials(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>?,
                                              isProxy: Int32,
                                              host: UnsafePointer<cef_string_t>?,
                                              port: Int32,
                                              realm: UnsafePointer<cef_string_t>?,
                                              scheme: UnsafePointer<cef_string_t>?,
                                              callback: UnsafeMutablePointer<cef_auth_callback_t>?) -> Int32 {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onAuthCredentialsRequired(isProxy: isProxy != 0,
                                               host: CEFStringToSwiftString(host!.pointee),
                                               port: UInt16(port),
                                               realm: realm != nil ? CEFStringToSwiftString(realm!.pointee) : nil,
                                               scheme: CEFStringToSwiftString(scheme!.pointee),
                                               callback: CEFAuthCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

