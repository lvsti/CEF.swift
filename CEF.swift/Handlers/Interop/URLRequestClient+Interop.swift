//
//  URLRequestClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func URLRequestClient_on_request_complete(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                          request: UnsafeMutablePointer<cef_urlrequest_t>) {
    guard let obj = URLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onRequestComplete(URLRequest.fromCEF(request)!)
}

func URLRequestClient_on_upload_progress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                         request: UnsafeMutablePointer<cef_urlrequest_t>,
                                         sent: Int64,
                                         total: Int64) {
    guard let obj = URLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onUploadProgress(URLRequest.fromCEF(request)!, sentCount: sent, totalCount: total)
}

func URLRequestClient_on_download_progress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                           request: UnsafeMutablePointer<cef_urlrequest_t>,
                                           received: Int64,
                                           total: Int64) {
    guard let obj = URLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadProgress(URLRequest.fromCEF(request)!, receivedCount: received, totalCount: total)
}

func URLRequestClient_on_download_data(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                       request: UnsafeMutablePointer<cef_urlrequest_t>,
                                       data: UnsafePointer<Void>,
                                       size: size_t) {
    guard let obj = URLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadData(URLRequest.fromCEF(request)!,
                       chunk: NSData(bytesNoCopy: UnsafeMutablePointer<Void>(data), length: size, freeWhenDone: false))
}

func URLRequestClient_get_auth_credentials(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                           isProxy: Int32,
                                           host: UnsafePointer<cef_string_t>,
                                           port: Int32,
                                           realm: UnsafePointer<cef_string_t>,
                                           scheme: UnsafePointer<cef_string_t>,
                                           callback: UnsafeMutablePointer<cef_auth_callback_t>) -> Int32 {
    guard let obj = URLRequestClientMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onAuthCredentialsRequired(isProxy != 0,
                                         host: CEFStringToSwiftString(host.memory),
                                         port: UInt16(port),
                                         realm: realm != nil ? CEFStringToSwiftString(realm.memory) : nil,
                                         scheme: CEFStringToSwiftString(scheme.memory),
                                         callback: AuthCallback.fromCEF(callback)!) ? 1 : 0
}

