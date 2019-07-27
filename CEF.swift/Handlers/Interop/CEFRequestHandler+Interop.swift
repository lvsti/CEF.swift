//
//  CEFRequestHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRequestHandler_on_before_browse(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                        browser: UnsafeMutablePointer<cef_browser_t>?,
                                        frame: UnsafeMutablePointer<cef_frame_t>?,
                                        request: UnsafeMutablePointer<cef_request_t>?,
                                        userGesture: Int32,
                                        isRedirect: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onBeforeBrowse(browser: CEFBrowser.fromCEF(browser)!,
                                    frame: CEFFrame.fromCEF(frame)!,
                                    request: CEFRequest.fromCEF(request)!,
                                    userGesture: userGesture != 0,
                                    isRedirect: isRedirect != 0)
    return action == .cancel ? 1 : 0
}

func CEFRequestHandler_on_open_urlfrom_tab(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           frame: UnsafeMutablePointer<cef_frame_t>?,
                                           url: UnsafePointer<cef_string_t>?,
                                           disposition: cef_window_open_disposition_t,
                                           gesture: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onOpenURLFromTab(browser: CEFBrowser.fromCEF(browser)!,
                                      frame: CEFFrame.fromCEF(frame)!,
                                      url: URL(string: CEFStringToSwiftString(url!.pointee))!,
                                      targetDisposition: CEFWindowOpenDisposition.fromCEF(disposition),
                                      userGesture: gesture != 0)
    return action == .cancel ? 1 : 0
}

func CEFRequestHandler_get_resource_request_handler(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    frame: UnsafeMutablePointer<cef_frame_t>?,
                                                    request: UnsafeMutablePointer<cef_request_t>?,
                                                    isNavigation: Int32,
                                                    isDownload: Int32,
                                                    initiator: UnsafePointer<cef_string_t>?,
                                                    cefDisableDefault: UnsafeMutablePointer<Int32>?) -> UnsafeMutablePointer<cef_resource_request_handler_t>? {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    var disableDefault: Bool = cefDisableDefault?.pointee != 0
    if let handler = obj.onGetResourceRequestHandler(browser: CEFBrowser.fromCEF(browser)!,
                                                     frame: CEFFrame.fromCEF(frame)!,
                                                     request: CEFRequest.fromCEF(request)!,
                                                     isNavigation: isNavigation != 0,
                                                     isDownload: isDownload != 0,
                                                     initiator: CEFStringToSwiftString(initiator!.pointee),
                                                     disableDefault: &disableDefault) {
        cefDisableDefault?.pointee = disableDefault ? 1 : 0
        return handler.toCEF()
    }
    
    return nil
}

func CEFRequestHandler_get_auth_credentials(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            originURL: UnsafePointer<cef_string_t>?,
                                            isProxy: Int32,
                                            host: UnsafePointer<cef_string_t>?,
                                            port: Int32,
                                            realm: UnsafePointer<cef_string_t>?,
                                            scheme: UnsafePointer<cef_string_t>?,
                                            callback: UnsafeMutablePointer<cef_auth_callback_t>?) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onAuthCredentialsRequired(browser: CEFBrowser.fromCEF(browser)!,
                                               originURL: URL(string: CEFStringToSwiftString(originURL!.pointee))!,
                                               isProxy: isProxy != 0,
                                               host: CEFStringToSwiftString(host!.pointee),
                                               port: UInt16(port),
                                               realm: CEFStringPtrToSwiftString(realm),
                                               scheme: CEFStringPtrToSwiftString(scheme),
                                               callback: CEFAuthCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFRequestHandler_on_quota_request(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                        browser: UnsafeMutablePointer<cef_browser_t>?,
                                        origin: UnsafePointer<cef_string_t>?,
                                        newSize: Int64,
                                        callback: UnsafeMutablePointer<cef_request_callback_t>?) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onQuotaRequest(browser: CEFBrowser.fromCEF(browser)!,
                                    origin: URL(string: CEFStringToSwiftString(origin!.pointee))!,
                                    newSize: newSize,
                                    callback: CEFRequestCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}


func CEFRequestHandler_on_certificate_error(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            errorCode: cef_errorcode_t,
                                            url: UnsafePointer<cef_string_t>?,
                                            sslInfo: UnsafeMutablePointer<cef_sslinfo_t>?,
                                            callback: UnsafeMutablePointer<cef_request_callback_t>?) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onCertificateError(browser: CEFBrowser.fromCEF(browser)!,
                                        errorCode: CEFErrorCode.fromCEF(errorCode.rawValue),
                                        url: URL(string: CEFStringToSwiftString(url!.pointee))!,
                                        sslInfo: CEFSSLInfo.fromCEF(sslInfo)!,
                                        callback: CEFRequestCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFRequestHandler_on_select_client_certificate(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    isProxy: Int32,
                                                    hostName: UnsafePointer<cef_string_t>?,
                                                    port: Int32,
                                                    certCount: Int,
                                                    certs: UnsafePointer<UnsafeMutablePointer<cef_x509certificate_t>?>?,
                                                    callback: UnsafeMutablePointer<cef_select_client_certificate_callback_t>?) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onSelectClientCertificate(browser: CEFBrowser.fromCEF(browser)!,
                                               isProxy: isProxy != 0,
                                               hostName: CEFStringToSwiftString(hostName!.pointee),
                                               port: UInt16(port),
                                               certificates: [],
                                               callback: CEFSelectClientCertificateCallback.fromCEF(callback)!)
    return action == .useSelected ? 1 : 0
}

func CEFRequestHandler_on_plugin_crashed(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                         browser: UnsafeMutablePointer<cef_browser_t>?,
                                         path: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPluginCrashed(browser: CEFBrowser.fromCEF(browser)!,
                        pluginPath: CEFStringToSwiftString(path!.pointee))
}

func CEFRequestHandler_on_render_view_ready(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderViewReady(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFRequestHandler_on_render_process_terminated(ptr: UnsafeMutablePointer<cef_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    status: cef_termination_status_t) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderProcessTerminated(browser: CEFBrowser.fromCEF(browser)!,
                                  status: CEFTerminationStatus.fromCEF(status))
}

