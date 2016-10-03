//
//  CEFDisplayHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDisplayHandler_on_address_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         frame: UnsafeMutablePointer<cef_frame_t>,
                                         url: UnsafePointer<cef_string_t>) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAddressChange(browser: CEFBrowser.fromCEF(browser)!,
                        frame: CEFFrame.fromCEF(frame)!,
                        url: NSURL(string: CEFStringToSwiftString(url.pointee))!)
}

func CEFDisplayHandler_on_title_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>,
                                       title: UnsafePointer<cef_string_t>) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onTitleChange(browser: CEFBrowser.fromCEF(browser)!,
                      title: title != nil ? CEFStringToSwiftString(title.pointee) : nil)
}

func CEFDisplayHandler_on_favicon_urlchange(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            urls: cef_string_list_t) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    let urlStrings: [String]? = urls != nil ? CEFStringListToSwiftArray(urls) : nil
    
    obj.onFaviconURLChange(browser: CEFBrowser.fromCEF(browser)!,
                           iconURLs: urlStrings?.map { NSURL(string: $0)! })
}

func CEFDisplayHandler_on_fullscreen_mode_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 fullscreen: Int32) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFullscreenModeChange(browser: CEFBrowser.fromCEF(browser)!, fullscreen: fullscreen != 0)
}

func CEFDisplayHandler_on_tooltip(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  textPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    var text: String? = textPtr != nil ? CEFStringToSwiftString(textPtr.pointee) : nil
    let action = obj.onTooltip(browser: CEFBrowser.fromCEF(browser)!, text: &text)
    
    if let text = text {
        CEFStringSetFromSwiftString(text, cefStringPtr: textPtr)
    }
    
    return action == .showCustom ? 1 : 0
}

func CEFDisplayHandler_on_status_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         text: UnsafePointer<cef_string_t>) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onStatusMessage(browser: CEFBrowser.fromCEF(browser)!,
                        text: CEFStringToSwiftString(text.pointee))
}

func CEFDisplayHandler_on_console_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          message: UnsafePointer<cef_string_t>,
                                          source: UnsafePointer<cef_string_t>,
                                          line: Int32) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onConsoleMessage(browser: CEFBrowser.fromCEF(browser)!,
                                      message: message != nil ? CEFStringToSwiftString(message.pointee) : nil,
                                      source: source != nil ? CEFStringToSwiftString(source.pointee) : nil,
                                      lineNumber: Int(line))
    return action == .cancel ? 1 : 0
}

