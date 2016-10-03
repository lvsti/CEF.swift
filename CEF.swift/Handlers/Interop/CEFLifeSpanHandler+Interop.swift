//
//  CEFLifeSpanHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFLifeSpanHandler_on_before_popup(ptr: UnsafeMutablePointer<cef_life_span_handler_t>?,
                                        browser: UnsafeMutablePointer<cef_browser_t>?,
                                        frame: UnsafeMutablePointer<cef_frame_t>?,
                                        url: UnsafePointer<cef_string_t>?,
                                        frameName: UnsafePointer<cef_string_t>?,
                                        disposition: cef_window_open_disposition_t,
                                        userGesture: Int32,
                                        features: UnsafePointer<cef_popup_features_t>?,
                                        windowInfo: UnsafeMutablePointer<cef_window_info_t>?,
                                        cefClient: UnsafeMutablePointer<UnsafeMutablePointer<cef_client_t>?>?,
                                        cefSettings: UnsafeMutablePointer<cef_browser_settings_t>?,
                                        noJSAccess: UnsafeMutablePointer<Int32>?) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var winInfo = CEFWindowInfo.fromCEF(windowInfo!.pointee)
    var client = CEFClientMarshaller.take(cefClient!.pointee)!
    var settings = CEFBrowserSettings.fromCEF(cefSettings!.pointee)
    var jsAccess = !(noJSAccess!.pointee != 0)
    
    let action = obj.onBeforePopup(browser: CEFBrowser.fromCEF(browser)!,
                                   frame: CEFFrame.fromCEF(frame)!,
                                   targetURL: url != nil ? NSURL(string: CEFStringToSwiftString(url!.pointee)) : nil,
                                   targetFrameName: frameName != nil ? CEFStringToSwiftString(frameName!.pointee) : nil,
                                   targetDisposition: CEFWindowOpenDisposition.fromCEF(disposition),
                                   userGesture: userGesture != 0,
                                   popupFeatures: CEFPopupFeatures.fromCEF(features!.pointee),
                                   windowInfo: &winInfo,
                                   client: &client,
                                   settings: &settings,
                                   jsAccess: &jsAccess)

    windowInfo!.pointee = winInfo.toCEF()
    cefClient!.pointee = CEFClientMarshaller.pass(client)
    cefSettings!.pointee = settings.toCEF()
    noJSAccess!.pointee = jsAccess ? 0 : 1
    
    return action == .cancel ? 1 : 0
}


func CEFLifeSpanHandler_on_after_created(ptr: UnsafeMutablePointer<cef_life_span_handler_t>?,
                                         browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAfterCreated(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFLifeSpanHandler_do_close(ptr: UnsafeMutablePointer<cef_life_span_handler_t>?,
                                 browser: UnsafeMutablePointer<cef_browser_t>?) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onDoClose(browser: CEFBrowser.fromCEF(browser)!)
    return action == .deferClose ? 1 : 0
}

func CEFLifeSpanHandler_on_before_close(ptr: UnsafeMutablePointer<cef_life_span_handler_t>?,
                                        browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeClose(browser: CEFBrowser.fromCEF(browser)!)
}

