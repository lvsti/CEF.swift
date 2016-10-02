//
//  CEFRequestHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRequestHandler_on_before_browse(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        frame: UnsafeMutablePointer<cef_frame_t>,
                                        request: UnsafeMutablePointer<cef_request_t>,
                                        isRedirect: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onBeforeBrowse(browser: CEFBrowser.fromCEF(browser)!,
                                    frame: CEFFrame.fromCEF(frame)!,
                                    request: CEFRequest.fromCEF(request)!,
                                    isRedirect: isRedirect != 0)
    return action == .cancel ? 1 : 0
}

func CEFRequestHandler_on_open_urlfrom_tab(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                           browser: UnsafeMutablePointer<cef_browser_t>,
                                           frame: UnsafeMutablePointer<cef_frame_t>,
                                           url: UnsafePointer<cef_string_t>,
                                           disposition: cef_window_open_disposition_t,
                                           gesture: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onOpenURLFromTab(browser: CEFBrowser.fromCEF(browser)!,
                                      frame: CEFFrame.fromCEF(frame)!,
                                      url: NSURL(string: CEFStringToSwiftString(url.pointee))!,
                                      targetDisposition: CEFWindowOpenDisposition.fromCEF(disposition),
                                      userGesture: gesture != 0)
    return action == .cancel ? 1 : 0
}

func CEFRequestHandler_on_before_resource_load(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                               browser: UnsafeMutablePointer<cef_browser_t>,
                                               frame: UnsafeMutablePointer<cef_frame_t>,
                                               request: UnsafeMutablePointer<cef_request_t>,
                                               callback: UnsafeMutablePointer<cef_request_callback_t>) -> cef_return_value_t {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return CEFReturnValue.continueNow.toCEF()
    }
    
    let retval = obj.onBeforeResourceLoad(browser: CEFBrowser.fromCEF(browser)!,
                                          frame: CEFFrame.fromCEF(frame)!,
                                          request: CEFRequest.fromCEF(request)!,
                                          callback: CEFRequestCallback.fromCEF(callback)!)
    
    return retval.toCEF()
}

func CEFRequestHandler_get_resource_handler(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            request: UnsafeMutablePointer<cef_request_t>) -> UnsafeMutablePointer<cef_resource_handler_t> {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.resourceHandlerForBrowser(browser: CEFBrowser.fromCEF(browser)!,
                                                   frame: CEFFrame.fromCEF(frame)!,
                                                   request: CEFRequest.fromCEF(request)!) {
        return handler.toCEF()
    }
    
    return nil
}


func CEFRequestHandler_on_resource_redirect(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            request: UnsafeMutablePointer<cef_request_t>,
                                            newURL: UnsafeMutablePointer<cef_string_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }

    var url = NSURL(string: CEFStringToSwiftString(newURL.pointee))!

    obj.onResourceRedirect(browser: CEFBrowser.fromCEF(browser)!,
                           frame: CEFFrame.fromCEF(frame)!,
                           request: CEFRequest.fromCEF(request)!,
                           newURL: &url)
    
    CEFStringSetFromSwiftString(url.absoluteString!, cefString: newURL)
}

func CEFRequestHandler_on_resource_response(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            request: UnsafeMutablePointer<cef_request_t>,
                                            response: UnsafeMutablePointer<cef_response_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onResourceResponse(browser: CEFBrowser.fromCEF(browser)!,
                                        frame: CEFFrame.fromCEF(frame)!,
                                        request: CEFRequest.fromCEF(request)!,
                                        response: CEFResponse.fromCEF(response)!)
    return action == .redirect || action == .retry ? 1 : 0
}

func CEFRequestHandler_get_resource_response_filter(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                                    frame: UnsafeMutablePointer<cef_frame_t>,
                                                    request: UnsafeMutablePointer<cef_request_t>,
                                                    response: UnsafeMutablePointer<cef_response_t>) -> UnsafeMutablePointer<cef_response_filter_t> {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    if let filter = obj.onResourceResponseFilter(browser: CEFBrowser.fromCEF(browser)!,
                                                 frame: CEFFrame.fromCEF(frame)!,
                                                 request: CEFRequest.fromCEF(request)!,
                                                 response: CEFResponse.fromCEF(response)!) {
        return filter.toCEF()
    }
    
    return nil
}

func CEFRequestHandler_on_resource_load_complete(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 frame: UnsafeMutablePointer<cef_frame_t>,
                                                 request: UnsafeMutablePointer<cef_request_t>,
                                                 response: UnsafeMutablePointer<cef_response_t>,
                                                 status: cef_urlrequest_status_t,
                                                 contentLength: Int64) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onResourceLoadComplete(browser: CEFBrowser.fromCEF(browser)!,
                               frame: CEFFrame.fromCEF(frame)!,
                               request: CEFRequest.fromCEF(request)!,
                               response: CEFResponse.fromCEF(response)!,
                               status: CEFURLRequestStatus.fromCEF(status),
                               contentLength: contentLength)
}

func CEFRequestHandler_get_auth_credentials(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            isProxy: Int32,
                                            host: UnsafePointer<cef_string_t>,
                                            port: Int32,
                                            realm: UnsafePointer<cef_string_t>,
                                            scheme: UnsafePointer<cef_string_t>,
                                            callback: UnsafeMutablePointer<cef_auth_callback_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onAuthCredentialsRequired(browser: CEFBrowser.fromCEF(browser)!,
                                               frame: CEFFrame.fromCEF(frame)!,
                                               isProxy: isProxy != 0,
                                               host: CEFStringToSwiftString(host.pointee),
                                               port: UInt16(port),
                                               realm: realm != nil ? CEFStringToSwiftString(realm.pointee) : nil,
                                               scheme: scheme != nil ? CEFStringToSwiftString(scheme.pointee) : nil,
                                               callback: CEFAuthCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}


func CEFRequestHandler_on_quota_request(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        origin: UnsafePointer<cef_string_t>,
                                        newSize: Int64,
                                        callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onQuotaRequest(browser: CEFBrowser.fromCEF(browser)!,
                                    origin: NSURL(string: CEFStringToSwiftString(origin.pointee))!,
                                    newSize: newSize,
                                    callback: CEFRequestCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}


func CEFRequestHandler_on_protocol_execution(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                             browser: UnsafeMutablePointer<cef_browser_t>,
                                             url: UnsafePointer<cef_string_t>,
                                             allow: UnsafeMutablePointer<Int32>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    var allowExecution: Bool = allow.pointee != 0
    obj.onProtocolExecution(browser: CEFBrowser.fromCEF(browser)!,
                            url: NSURL(string: CEFStringToSwiftString(url.pointee))!,
                            allowExecution: &allowExecution)
    allow.pointee = allowExecution ? 1 : 0
}

func CEFRequestHandler_on_certificate_error(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            errorCode: cef_errorcode_t,
                                            url: UnsafePointer<cef_string_t>,
                                            sslInfo: UnsafeMutablePointer<cef_sslinfo_t>,
                                            callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onCertificateError(browser: CEFBrowser.fromCEF(browser)!,
                                        errorCode: CEFErrorCode.fromCEF(errorCode.rawValue),
                                        url: NSURL(string: CEFStringToSwiftString(url.pointee))!,
                                        sslInfo: CEFSSLInfo.fromCEF(sslInfo)!,
                                        callback: CEFRequestCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFRequestHandler_on_plugin_crashed(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         path: UnsafePointer<cef_string_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPluginCrashed(browser: CEFBrowser.fromCEF(browser)!,
                        pluginPath: CEFStringToSwiftString(path.pointee))
}

func CEFRequestHandler_on_render_view_ready(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderViewReady(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFRequestHandler_on_render_process_terminated(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                                    status: cef_termination_status_t) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderProcessTerminated(browser: CEFBrowser.fromCEF(browser)!,
                                  status: CEFTerminationStatus.fromCEF(status))
}

