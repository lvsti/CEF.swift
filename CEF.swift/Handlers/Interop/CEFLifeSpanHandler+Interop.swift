//
//  CEFLifeSpanHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFLifeSpanHandler_onBeforePopup(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      frame: UnsafeMutablePointer<cef_frame_t>,
                                      url: UnsafePointer<cef_string_t>,
                                      frameName: UnsafePointer<cef_string_t>,
                                      disposition: cef_window_open_disposition_t,
                                      userGesture: Int32,
                                      features: UnsafePointer<cef_popup_features_t>,
                                      windowInfo: UnsafeMutablePointer<cef_window_info_t>,
                                      cefClient: UnsafeMutablePointer<UnsafeMutablePointer<cef_client_t>>,
                                      cefSettings: UnsafeMutablePointer<cef_browser_settings_t>,
                                      noJSAccess: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var winInfo = CEFWindowInfo.fromCEF(windowInfo.memory)
    var client = CEFClientMarshaller.take(cefClient.memory)!
    var settings = CEFBrowserSettings.fromCEF(cefSettings.memory)
    var jsAccess = !(noJSAccess.memory != 0)
    
    let retval = obj.onBeforePopup(CEFBrowser.fromCEF(browser)!,
        frame: CEFFrame.fromCEF(frame)!,
        targetURL: url != nil ? NSURL(string: CEFStringToSwiftString(url.memory)) : nil,
        targetFrameName: frameName != nil ? CEFStringToSwiftString(frameName.memory) : nil,
        targetDisposition: CEFWindowOpenDisposition.fromCEF(disposition),
        userGesture: userGesture != 0,
        popupFeatures: CEFPopupFeatures.fromCEF(features.memory),
        windowInfo: &winInfo,
        client: &client,
        settings: &settings,
        jsAccess: &jsAccess)

    windowInfo.memory = winInfo.toCEF()
    cefClient.memory = CEFClientMarshaller.pass(client)
    cefSettings.memory = settings.toCEF()
    noJSAccess.memory = jsAccess ? 0 : 1
    
    return retval ? 1 : 0
}


func CEFLifeSpanHandler_onAfterCreated(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAfterCreated(CEFBrowser.fromCEF(browser)!)
}

func CEFLifeSpanHandler_runModal(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.runModal(CEFBrowser.fromCEF(browser)!) ? 1 : 0
}

func CEFLifeSpanHandler_doClose(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                browser: UnsafeMutablePointer<cef_browser_t>) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.doClose(CEFBrowser.fromCEF(browser)!) ? 1 : 0
}

func CEFLifeSpanHandler_onBeforeClose(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeClose(CEFBrowser.fromCEF(browser)!)
}

