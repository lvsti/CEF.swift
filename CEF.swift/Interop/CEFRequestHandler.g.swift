//
//  CEFRequestHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_request_handler_t: CEFObject {
}

typealias CEFRequestHandlerMarshaller = CEFMarshaller<CEFRequestHandler, cef_request_handler_t>

extension CEFRequestHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_handler_t> {
        return CEFRequestHandlerMarshaller.pass(self)
    }
}

extension cef_request_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_browse = CEFRequestHandler_onBeforeBrowse
        on_open_urlfrom_tab = CEFRequestHandler_onOpenURLFromTab
        on_before_resource_load = CEFRequestHandler_onBeforeResourceLoad
        get_resource_handler = CEFRequestHandler_getResourceHandler
        on_resource_redirect = CEFRequestHandler_onResourceRedirect
        on_resource_response = CEFRequestHandler_onResourceResponse
        get_auth_credentials = CEFRequestHandler_getAuthCredentials
        on_quota_request = CEFRequestHandler_onQuotaRequest
        on_protocol_execution = CEFRequestHandler_onProtocolExecution
        on_certificate_error = CEFRequestHandler_onCertificateError
        on_before_plugin_load = CEFRequestHandler_onBeforePluginLoad
        on_plugin_crashed = CEFRequestHandler_onPluginCrashed
        on_render_view_ready = CEFRequestHandler_onRenderViewReady
        on_render_process_terminated = CEFRequestHandler_onRenderProcessTerminated
    }
}

func CEFRequestHandler_onBeforeBrowse(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      frame: UnsafeMutablePointer<cef_frame_t>,
                                      request: UnsafeMutablePointer<cef_request_t>,
                                      isRedirect: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onBeforeBrowse(CEFBrowser.fromCEF(browser)!,
                              frame: CEFFrame.fromCEF(frame)!,
                              request: CEFRequest.fromCEF(request)!,
                              isRedirect: isRedirect != 0) ? 1 : 0
}

func CEFRequestHandler_onOpenURLFromTab(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        frame: UnsafeMutablePointer<cef_frame_t>,
                                        url: UnsafePointer<cef_string_t>,
                                        disposition: cef_window_open_disposition_t,
                                        gesture: Int32) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onOpenURLFromTab(CEFBrowser.fromCEF(browser)!,
                                frame: CEFFrame.fromCEF(frame)!,
                                url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                targetDisposition: CEFWindowOpenDisposition.fromCEF(disposition),
                                userGesture: gesture != 0) ? 1 : 0
}

func CEFRequestHandler_onBeforeResourceLoad(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            request: UnsafeMutablePointer<cef_request_t>,
                                            callback: UnsafeMutablePointer<cef_request_callback_t>) -> cef_return_value_t {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return CEFReturnValue.Continue.toCEF()
    }
    
    let retval = obj.onBeforeResourceLoad(CEFBrowser.fromCEF(browser)!,
                                          frame: CEFFrame.fromCEF(frame)!,
                                          request: CEFRequest.fromCEF(request)!,
                                          callback: CEFRequestCallback.fromCEF(callback)!)
    
    return retval.toCEF()
}

func CEFRequestHandler_getResourceHandler(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          frame: UnsafeMutablePointer<cef_frame_t>,
                                          request: UnsafeMutablePointer<cef_request_t>) -> UnsafeMutablePointer<cef_resource_handler_t> {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.getResourceHandler(CEFBrowser.fromCEF(browser)!,
                                            frame: CEFFrame.fromCEF(frame)!,
                                            request: CEFRequest.fromCEF(request)!) {
        return handler.toCEF()
    }
    
    return nil
}


func CEFRequestHandler_onResourceRedirect(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          frame: UnsafeMutablePointer<cef_frame_t>,
                                          request: UnsafeMutablePointer<cef_request_t>,
                                          newURL: UnsafeMutablePointer<cef_string_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }

    var url = NSURL(string: CEFStringToSwiftString(newURL.memory))!

    obj.onResourceRedirect(CEFBrowser.fromCEF(browser)!,
        frame: CEFFrame.fromCEF(frame)!,
        request: CEFRequest.fromCEF(request)!,
        newURL: &url)
    
    CEFStringSetFromSwiftString(url.absoluteString, cefString: newURL)
}

func CEFRequestHandler_onResourceResponse(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          frame: UnsafeMutablePointer<cef_frame_t>,
                                          request: UnsafeMutablePointer<cef_request_t>,
                                          response: UnsafeMutablePointer<cef_response_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onResourceResponse(CEFBrowser.fromCEF(browser)!,
        frame: CEFFrame.fromCEF(frame)!,
        request: CEFRequest.fromCEF(request)!,
        response: CEFResponse.fromCEF(response)!) ? 1 : 0
}


func CEFRequestHandler_getAuthCredentials(ptr: UnsafeMutablePointer<cef_request_handler_t>,
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
    
    return obj.getAuthCredentials(CEFBrowser.fromCEF(browser)!,
                                  frame: CEFFrame.fromCEF(frame)!,
                                  isProxy: isProxy != 0,
                                  host: CEFStringToSwiftString(host.memory),
                                  port: UInt16(port),
                                  realm: CEFStringToSwiftString(realm.memory),
                                  scheme: CEFStringToSwiftString(scheme.memory),
                                  callback: CEFAuthCallback.fromCEF(callback)!) ? 1 : 0
}


func CEFRequestHandler_onQuotaRequest(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      origin: UnsafePointer<cef_string_t>,
                                      newSize: Int64,
                                      callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onQuotaRequest(CEFBrowser.fromCEF(browser)!,
                              origin: NSURL(string: CEFStringToSwiftString(origin.memory))!,
                              newSize: newSize,
                              callback: CEFRequestCallback.fromCEF(callback)!) ? 1 : 0
}


func CEFRequestHandler_onProtocolExecution(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                           browser: UnsafeMutablePointer<cef_browser_t>,
                                           url: UnsafePointer<cef_string_t>,
                                           allow: UnsafeMutablePointer<Int32>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    var allowExecution: Bool = allow.memory != 0
    obj.onProtocolExecution(CEFBrowser.fromCEF(browser)!,
                            url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                            allowExecution: &allowExecution)
    allow.memory = allowExecution ? 1 : 0
}

func CEFRequestHandler_onCertificateError(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          errorCode: cef_errorcode_t,
                                          url: UnsafePointer<cef_string_t>,
                                          sslInfo: UnsafeMutablePointer<cef_sslinfo_t>,
                                          callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onCertificateError(CEFBrowser.fromCEF(browser)!,
                                  errorCode: CEFErrorCode.fromCEF(errorCode.rawValue),
                                  url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                  sslInfo: CEFSSLInfo.fromCEF(sslInfo)!,
                                  callback: CEFRequestCallback.fromCEF(callback)!) ? 1 : 0
}

func CEFRequestHandler_onBeforePluginLoad(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          url: UnsafePointer<cef_string_t>,
                                          policyURL: UnsafePointer<cef_string_t>,
                                          pluginInfo: UnsafeMutablePointer<cef_web_plugin_info_t>) -> Int32 {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onBeforePluginLoad(CEFBrowser.fromCEF(browser)!,
                                  url: url != nil ? NSURL(string: CEFStringToSwiftString(url.memory))! : nil,
                                  policyURL: policyURL != nil ? NSURL(string: CEFStringToSwiftString(policyURL.memory))! : nil,
                                  pluginInfo: CEFWebPluginInfo.fromCEF(pluginInfo)!) ? 1 : 0
}


func CEFRequestHandler_onPluginCrashed(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>,
                                       path: UnsafePointer<cef_string_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPluginCrashed(CEFBrowser.fromCEF(browser)!,
                        pluginPath: CEFStringToSwiftString(path.memory))
}

func CEFRequestHandler_onRenderViewReady(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderViewReady(CEFBrowser.fromCEF(browser)!)
}

func CEFRequestHandler_onRenderProcessTerminated(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 status: cef_termination_status_t) {
    guard let obj = CEFRequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderProcessTerminated(CEFBrowser.fromCEF(browser)!,
                                  status: CEFTerminationStatus.fromCEF(status))
}

