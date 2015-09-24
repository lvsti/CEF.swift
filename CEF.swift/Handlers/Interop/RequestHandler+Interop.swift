//
//  RequestHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func RequestHandler_on_before_browse(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                     browser: UnsafeMutablePointer<cef_browser_t>,
                                     frame: UnsafeMutablePointer<cef_frame_t>,
                                     request: UnsafeMutablePointer<cef_request_t>,
                                     isRedirect: Int32) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onBeforeBrowse(Browser.fromCEF(browser)!,
                              frame: Frame.fromCEF(frame)!,
                              request: Request.fromCEF(request)!,
                              isRedirect: isRedirect != 0) ? 1 : 0
}

func RequestHandler_on_open_urlfrom_tab(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        frame: UnsafeMutablePointer<cef_frame_t>,
                                        url: UnsafePointer<cef_string_t>,
                                        disposition: cef_window_open_disposition_t,
                                        gesture: Int32) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onOpenURLFromTab(Browser.fromCEF(browser)!,
                                frame: Frame.fromCEF(frame)!,
                                url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                targetDisposition: WindowOpenDisposition.fromCEF(disposition),
                                userGesture: gesture != 0) ? 1 : 0
}

func RequestHandler_on_before_resource_load(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            frame: UnsafeMutablePointer<cef_frame_t>,
                                            request: UnsafeMutablePointer<cef_request_t>,
                                            callback: UnsafeMutablePointer<cef_request_callback_t>) -> cef_return_value_t {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return ReturnValue.Continue.toCEF()
    }
    
    let retval = obj.onBeforeResourceLoad(Browser.fromCEF(browser)!,
                                          frame: Frame.fromCEF(frame)!,
                                          request: Request.fromCEF(request)!,
                                          callback: RequestCallback.fromCEF(callback)!)
    
    return retval.toCEF()
}

func RequestHandler_get_resource_handler(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         frame: UnsafeMutablePointer<cef_frame_t>,
                                         request: UnsafeMutablePointer<cef_request_t>) -> UnsafeMutablePointer<cef_resource_handler_t> {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    if let handler = obj.resourceHandlerForBrowser(Browser.fromCEF(browser)!,
                                                   frame: Frame.fromCEF(frame)!,
                                                   request: Request.fromCEF(request)!) {
        return handler.toCEF()
    }
    
    return nil
}


func RequestHandler_on_resource_redirect(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         frame: UnsafeMutablePointer<cef_frame_t>,
                                         request: UnsafeMutablePointer<cef_request_t>,
                                         newURL: UnsafeMutablePointer<cef_string_t>) {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return
    }

    var url = NSURL(string: CEFStringToSwiftString(newURL.memory))!

    obj.onResourceRedirect(Browser.fromCEF(browser)!,
        frame: Frame.fromCEF(frame)!,
        request: Request.fromCEF(request)!,
        newURL: &url)
    
    CEFStringSetFromSwiftString(url.absoluteString, cefString: newURL)
}

func RequestHandler_on_resource_response(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         frame: UnsafeMutablePointer<cef_frame_t>,
                                         request: UnsafeMutablePointer<cef_request_t>,
                                         response: UnsafeMutablePointer<cef_response_t>) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onResourceResponse(Browser.fromCEF(browser)!,
        frame: Frame.fromCEF(frame)!,
        request: Request.fromCEF(request)!,
        response: Response.fromCEF(response)!) ? 1 : 0
}


func RequestHandler_get_auth_credentials(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         frame: UnsafeMutablePointer<cef_frame_t>,
                                         isProxy: Int32,
                                         host: UnsafePointer<cef_string_t>,
                                         port: Int32,
                                         realm: UnsafePointer<cef_string_t>,
                                         scheme: UnsafePointer<cef_string_t>,
                                         callback: UnsafeMutablePointer<cef_auth_callback_t>) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onAuthCredentialsRequired(Browser.fromCEF(browser)!,
                                         frame: Frame.fromCEF(frame)!,
                                         isProxy: isProxy != 0,
                                         host: CEFStringToSwiftString(host.memory),
                                         port: UInt16(port),
                                         realm: CEFStringToSwiftString(realm.memory),
                                         scheme: CEFStringToSwiftString(scheme.memory),
                                         callback: AuthCallback.fromCEF(callback)!) ? 1 : 0
}


func RequestHandler_on_quota_request(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                     browser: UnsafeMutablePointer<cef_browser_t>,
                                     origin: UnsafePointer<cef_string_t>,
                                     newSize: Int64,
                                     callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onQuotaRequest(Browser.fromCEF(browser)!,
                              origin: NSURL(string: CEFStringToSwiftString(origin.memory))!,
                              newSize: newSize,
                              callback: RequestCallback.fromCEF(callback)!) ? 1 : 0
}


func RequestHandler_on_protocol_execution(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          url: UnsafePointer<cef_string_t>,
                                          allow: UnsafeMutablePointer<Int32>) {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    var allowExecution: Bool = allow.memory != 0
    obj.onProtocolExecution(Browser.fromCEF(browser)!,
                            url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                            allowExecution: &allowExecution)
    allow.memory = allowExecution ? 1 : 0
}

func RequestHandler_on_certificate_error(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         errorCode: cef_errorcode_t,
                                         url: UnsafePointer<cef_string_t>,
                                         sslInfo: UnsafeMutablePointer<cef_sslinfo_t>,
                                         callback: UnsafeMutablePointer<cef_request_callback_t>) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onCertificateError(Browser.fromCEF(browser)!,
                                  errorCode: ErrorCode.fromCEF(errorCode.rawValue),
                                  url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                  sslInfo: SSLInfo.fromCEF(sslInfo)!,
                                  callback: RequestCallback.fromCEF(callback)!) ? 1 : 0
}

func RequestHandler_on_before_plugin_load(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          url: UnsafePointer<cef_string_t>,
                                          policyURL: UnsafePointer<cef_string_t>,
                                          pluginInfo: UnsafeMutablePointer<cef_web_plugin_info_t>) -> Int32 {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onBeforePluginLoad(Browser.fromCEF(browser)!,
                                  url: url != nil ? NSURL(string: CEFStringToSwiftString(url.memory))! : nil,
                                  policyURL: policyURL != nil ? NSURL(string: CEFStringToSwiftString(policyURL.memory))! : nil,
                                  pluginInfo: WebPluginInfo.fromCEF(pluginInfo)!) ? 1 : 0
}


func RequestHandler_on_plugin_crashed(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      path: UnsafePointer<cef_string_t>) {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPluginCrashed(Browser.fromCEF(browser)!,
                        pluginPath: CEFStringToSwiftString(path.memory))
}

func RequestHandler_on_render_view_ready(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderViewReady(Browser.fromCEF(browser)!)
}

func RequestHandler_on_render_process_terminated(ptr: UnsafeMutablePointer<cef_request_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 status: cef_termination_status_t) {
    guard let obj = RequestHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onRenderProcessTerminated(Browser.fromCEF(browser)!,
                                  status: TerminationStatus.fromCEF(status))
}

