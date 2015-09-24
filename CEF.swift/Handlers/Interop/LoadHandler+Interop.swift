//
//  LoadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func LoadHandler_on_loading_state_change(ptr: UnsafeMutablePointer<cef_load_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         isLoading: Int32,
                                         canGoBack: Int32,
                                         canGoForward: Int32) {
    guard let obj = LoadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onLoadingStateChange(Browser.fromCEF(browser)!,
					         isLoading: isLoading != 0,
                             canGoBack: canGoBack != 0,
                             canGoForward: canGoForward != 0)
}

func LoadHandler_on_load_start(ptr: UnsafeMutablePointer<cef_load_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>,
                               frame: UnsafeMutablePointer<cef_frame_t>) {
    guard let obj = LoadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onLoadStart(Browser.fromCEF(browser)!, frame: Frame.fromCEF(frame)!)
}

func LoadHandler_on_load_end(ptr: UnsafeMutablePointer<cef_load_handler_t>,
                             browser: UnsafeMutablePointer<cef_browser_t>,
                             frame: UnsafeMutablePointer<cef_frame_t>,
                             statusCode: Int32) {
    guard let obj = LoadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onLoadEnd(Browser.fromCEF(browser)!,
                  frame: Frame.fromCEF(frame)!,
                  statusCode: Int(statusCode))
}

func LoadHandler_on_load_error(ptr: UnsafeMutablePointer<cef_load_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>,
                               frame: UnsafeMutablePointer<cef_frame_t>,
                               errorCode: cef_errorcode_t,
                               errorMsg: UnsafePointer<cef_string_t>,
                               url: UnsafePointer<cef_string_t>) {
    guard let obj = LoadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onLoadError(Browser.fromCEF(browser)!,
                    frame: Frame.fromCEF(frame)!,
                    errorCode: ErrorCode.fromCEF(errorCode.rawValue),
                    errorMessage: CEFStringToSwiftString(errorMsg.memory),
                    url: NSURL(string: CEFStringToSwiftString(url.memory))!)
}

