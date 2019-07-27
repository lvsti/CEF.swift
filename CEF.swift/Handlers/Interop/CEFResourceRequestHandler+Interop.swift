//
//  CEFResourceRequestHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 27..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResourceRequestHandler_get_cookie_access_filter(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                        browser: UnsafeMutablePointer<cef_browser_t>?,
                                                        frame: UnsafeMutablePointer<cef_frame_t>?,
                                                        request: UnsafeMutablePointer<cef_request_t>?) -> UnsafeMutablePointer<cef_cookie_access_filter_t>? {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    let filter = obj.cookieAccessFilter(browser: CEFBrowser.fromCEF(browser),
                                        frame: CEFFrame.fromCEF(frame),
                                        request: CEFRequest.fromCEF(request)!)
    return filter?.toCEF()
}

func CEFResourceRequestHandler_on_before_resource_load(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                       browser: UnsafeMutablePointer<cef_browser_t>?,
                                                       frame: UnsafeMutablePointer<cef_frame_t>?,
                                                       request: UnsafeMutablePointer<cef_request_t>?,
                                                       callback: UnsafeMutablePointer<cef_request_callback_t>?) -> cef_return_value_t {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return RV_CANCEL
    }
    
    let action = obj.onBeforeResourceLoad(browser: CEFBrowser.fromCEF(browser),
                                          frame: CEFFrame.fromCEF(frame),
                                          request: CEFRequest.fromCEF(request)!,
                                          callback: CEFRequestCallback.fromCEF(callback)!)
    
    return action.toCEF()
}

func CEFResourceRequestHandler_get_resource_handler(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    frame: UnsafeMutablePointer<cef_frame_t>?,
                                                    request: UnsafeMutablePointer<cef_request_t>?) -> UnsafeMutablePointer<cef_resource_handler_t>? {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    let handler = obj.resourceHandler(browser: CEFBrowser.fromCEF(browser),
                                      frame: CEFFrame.fromCEF(frame),
                                      request: CEFRequest.fromCEF(request)!)
    return handler?.toCEF()
}

func CEFResourceRequestHandler_on_resource_redirect(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    frame: UnsafeMutablePointer<cef_frame_t>?,
                                                    request: UnsafeMutablePointer<cef_request_t>?,
                                                    response: UnsafeMutablePointer<cef_response_t>?,
                                                    newURL: UnsafeMutablePointer<cef_string_t>?) {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    var url = URL(string: CEFStringToSwiftString(newURL!.pointee))!
    
    obj.onResourceRedirect(browser: CEFBrowser.fromCEF(browser),
                           frame: CEFFrame.fromCEF(frame),
                           request: CEFRequest.fromCEF(request)!,
                           response: CEFResponse.fromCEF(response)!,
                           newURL: &url)
    
    CEFStringSetFromSwiftString(url.absoluteString, cefStringPtr: newURL!)
}

func CEFResourceRequestHandler_on_resource_response(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                                    frame: UnsafeMutablePointer<cef_frame_t>?,
                                                    request: UnsafeMutablePointer<cef_request_t>?,
                                                    response: UnsafeMutablePointer<cef_response_t>?) -> Int32 {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onResourceResponse(browser: CEFBrowser.fromCEF(browser),
                                        frame: CEFFrame.fromCEF(frame),
                                        request: CEFRequest.fromCEF(request)!,
                                        response: CEFResponse.fromCEF(response)!)
    return action == .redirect || action == .retry ? 1 : 0
}

func CEFResourceRequestHandler_get_resource_response_filter(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                                            frame: UnsafeMutablePointer<cef_frame_t>?,
                                                            request: UnsafeMutablePointer<cef_request_t>?,
                                                            response: UnsafeMutablePointer<cef_response_t>?) -> UnsafeMutablePointer<cef_response_filter_t>? {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return nil
    }

    let filter = obj.resourceResponseFilter(browser: CEFBrowser.fromCEF(browser),
                                            frame: CEFFrame.fromCEF(frame),
                                            request: CEFRequest.fromCEF(request)!,
                                            response: CEFResponse.fromCEF(response)!)
    return filter?.toCEF()
}

func CEFResourceRequestHandler_on_resource_load_complete(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                         browser: UnsafeMutablePointer<cef_browser_t>?,
                                                         frame: UnsafeMutablePointer<cef_frame_t>?,
                                                         request: UnsafeMutablePointer<cef_request_t>?,
                                                         response: UnsafeMutablePointer<cef_response_t>?,
                                                         status: cef_urlrequest_status_t,
                                                         contentLength: Int64) {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onResourceLoadComplete(browser: CEFBrowser.fromCEF(browser),
                               frame: CEFFrame.fromCEF(frame),
                               request: CEFRequest.fromCEF(request)!,
                               response: CEFResponse.fromCEF(response)!,
                               status: CEFURLRequestStatus.fromCEF(status),
                               contentLength: contentLength)
}

func CEFResourceRequestHandler_on_protocol_execution(ptr: UnsafeMutablePointer<cef_resource_request_handler_t>?,
                                                     browser: UnsafeMutablePointer<cef_browser_t>?,
                                                     frame: UnsafeMutablePointer<cef_frame_t>?,
                                                     request: UnsafeMutablePointer<cef_request_t>?,
                                                     allowExecution: UnsafeMutablePointer<Int32>?) {
    guard let obj = CEFResourceRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    let action = obj.onProtocolExecution(browser: CEFBrowser.fromCEF(browser),
                                         frame: CEFFrame.fromCEF(frame),
                                         request: CEFRequest.fromCEF(request)!)
    
    allowExecution?.pointee = action == .allow ? 1 : 0
}
