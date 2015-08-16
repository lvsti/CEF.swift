//
//  CEFURLRequestClient.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_urlrequest_client_t: CEFObject {
}

typealias CEFURLRequestClientMarshaller = CEFMarshaller<CEFURLRequestClient, cef_urlrequest_client_t>

extension CEFURLRequestClient {
    func toCEF() -> UnsafeMutablePointer<cef_urlrequest_client_t> {
        return CEFURLRequestClientMarshaller.pass(self)
    }
}

extension cef_urlrequest_client_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_request_complete = CEFURLRequestClient_onRequestComplete
        on_upload_progress = CEFURLRequestClient_onUploadProgress
        on_download_progress = CEFURLRequestClient_onDownloadProgress
        on_download_data = CEFURLRequestClient_onDownloadData
        get_auth_credentials = CEFURLRequestClient_getAuthCredentials
    }
}

func CEFURLRequestClient_onRequestComplete(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                           request: UnsafeMutablePointer<cef_urlrequest_t>) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onRequestComplete(CEFURLRequest.fromCEF(request)!)
}

func CEFURLRequestClient_onUploadProgress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                          request: UnsafeMutablePointer<cef_urlrequest_t>,
                                          sent: Int64,
                                          total: Int64) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onUploadProgress(CEFURLRequest.fromCEF(request)!, sentCount: sent, totalCount: total)
}

func CEFURLRequestClient_onDownloadProgress(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                            request: UnsafeMutablePointer<cef_urlrequest_t>,
                                            received: Int64,
                                            total: Int64) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadProgress(CEFURLRequest.fromCEF(request)!, receivedCount: received, totalCount: total)
}

func CEFURLRequestClient_onDownloadData(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                        request: UnsafeMutablePointer<cef_urlrequest_t>,
                                        data: UnsafePointer<Void>,
                                        size: size_t) {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadData(CEFURLRequest.fromCEF(request)!,
                       chunk: NSData(bytesNoCopy: UnsafeMutablePointer<Void>(data), length: size, freeWhenDone: false))
}

func CEFURLRequestClient_getAuthCredentials(ptr: UnsafeMutablePointer<cef_urlrequest_client_t>,
                                            isProxy: Int32,
                                            host: UnsafePointer<cef_string_t>,
                                            port: Int32,
                                            realm: UnsafePointer<cef_string_t>,
                                            scheme: UnsafePointer<cef_string_t>,
                                            callback: UnsafeMutablePointer<cef_auth_callback_t>) -> Int32 {
    guard let obj = CEFURLRequestClientMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.getAuthCredentials(isProxy != 0,
                                  host: CEFStringToSwiftString(host.memory),
                                  port: UInt16(port),
                                  realm: realm != nil ? CEFStringToSwiftString(realm.memory) : nil,
                                  scheme: CEFStringToSwiftString(scheme.memory),
                                  callback: CEFAuthCallback.fromCEF(callback)!) ? 1 : 0
}

