//
//  GeolocationHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func GeolocationHandler_on_request_geolocation_permission(ptr: UnsafeMutablePointer<cef_geolocation_handler_t>,
                                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                                          url: UnsafePointer<cef_string_t>,
                                                          requestID: Int32,
                                                          callback: UnsafeMutablePointer<cef_geolocation_callback_t>) -> Int32 {
    guard let obj = GeolocationHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onRequestGeolocationPermission(Browser.fromCEF(browser)!,
                                              url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                              requestID: requestID,
                                              callback: GeolocationCallback.fromCEF(callback)!) ? 1 : 0
}

func GeolocationHandler_on_cancel_geolocation_permission(ptr: UnsafeMutablePointer<cef_geolocation_handler_t>,
                                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                                         url: UnsafePointer<cef_string_t>,
                                                         requestID: Int32) {
    guard let obj = GeolocationHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onCancelGeolocationPermission(Browser.fromCEF(browser)!,
                                      url: NSURL(string: CEFStringToSwiftString(url.memory))!,
                                      requestID: requestID)
}

