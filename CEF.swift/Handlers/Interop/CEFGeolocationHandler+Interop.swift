//
//  CEFGeolocationHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFGeolocationHandler_on_request_geolocation_permission(ptr: UnsafeMutablePointer<cef_geolocation_handler_t>?,
                                                             browser: UnsafeMutablePointer<cef_browser_t>?,
                                                             url: UnsafePointer<cef_string_t>?,
                                                             requestID: Int32,
                                                             callback: UnsafeMutablePointer<cef_geolocation_callback_t>?) -> Int32 {
    guard let obj = CEFGeolocationHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onRequestGeolocationPermission(browser: CEFBrowser.fromCEF(browser)!,
                                                    url: URL(string: CEFStringToSwiftString(url!.pointee))!,
                                                    requestID: requestID,
                                                    callback: CEFGeolocationCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFGeolocationHandler_on_cancel_geolocation_permission(ptr: UnsafeMutablePointer<cef_geolocation_handler_t>?,
                                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                                            requestID: Int32) {
    guard let obj = CEFGeolocationHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onCancelGeolocationPermissionRequest(browser: CEFBrowser.fromCEF(browser)!,
                                             requestID: requestID)
}

