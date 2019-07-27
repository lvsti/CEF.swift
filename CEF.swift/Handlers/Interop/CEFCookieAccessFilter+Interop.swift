//
//  CEFCookieAccessFilter+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 07. 27..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFCookieAccessFilter_can_send_cookie(ptr: UnsafeMutablePointer<cef_cookie_access_filter_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           frame: UnsafeMutablePointer<cef_frame_t>?,
                                           request: UnsafeMutablePointer<cef_request_t>?,
                                           cookie: UnsafePointer<cef_cookie_t>?) -> Int32 {
    guard let obj = CEFCookieAccessFilterMarshaller.get(ptr) else {
        return 0
    }

    return obj.canSendCookie(browser: CEFBrowser.fromCEF(browser),
                             frame: CEFFrame.fromCEF(frame),
                             request: CEFRequest.fromCEF(request)!,
                             cookie: CEFCookie.fromCEF(cookie!.pointee)) ? 1 : 0
}

func CEFCookieAccessFilter_can_save_cookie(ptr: UnsafeMutablePointer<cef_cookie_access_filter_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           frame: UnsafeMutablePointer<cef_frame_t>?,
                                           request: UnsafeMutablePointer<cef_request_t>?,
                                           response: UnsafeMutablePointer<cef_response_t>?,
                                           cookie: UnsafePointer<cef_cookie_t>?) -> Int32 {
    guard let obj = CEFCookieAccessFilterMarshaller.get(ptr) else {
        return 0
    }

    return obj.canSaveCookie(browser: CEFBrowser.fromCEF(browser),
                             frame: CEFFrame.fromCEF(frame),
                             request: CEFRequest.fromCEF(request)!,
                             response: CEFResponse.fromCEF(response)!,
                             cookie: CEFCookie.fromCEF(cookie!.pointee)) ? 1 : 0
}
