//
//  CEFDisplayHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDisplayHandler_on_address_change(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                         browser: UnsafeMutablePointer<cef_browser_t>?,
                                         frame: UnsafeMutablePointer<cef_frame_t>?,
                                         url: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAddressChange(browser: CEFBrowser.fromCEF(browser)!,
                        frame: CEFFrame.fromCEF(frame)!,
                        url: URL(string: CEFStringToSwiftString(url!.pointee))!)
}

func CEFDisplayHandler_on_title_change(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                       browser: UnsafeMutablePointer<cef_browser_t>?,
                                       title: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onTitleChange(browser: CEFBrowser.fromCEF(browser)!,
                      title: title != nil ? CEFStringToSwiftString(title!.pointee) : nil)
}

func CEFDisplayHandler_on_favicon_urlchange(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            urls: cef_string_list_t?) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    let urlStrings: [String]? = urls != nil ? CEFStringListToSwiftArray(urls!) : nil
    
    obj.onFaviconURLChange(browser: CEFBrowser.fromCEF(browser)!,
                           iconURLs: urlStrings?.map { URL(string: $0)! })
}

func CEFDisplayHandler_on_fullscreen_mode_change(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                                 browser: UnsafeMutablePointer<cef_browser_t>?,
                                                 fullscreen: Int32) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFullscreenModeChange(browser: CEFBrowser.fromCEF(browser)!, fullscreen: fullscreen != 0)
}

func CEFDisplayHandler_on_tooltip(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                  browser: UnsafeMutablePointer<cef_browser_t>?,
                                  textPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    let text = CEFStringToSwiftString(textPtr!.pointee)
    let action = obj.onTooltip(browser: CEFBrowser.fromCEF(browser)!, text: text)
    
    switch action {
    case .showCustom:
        return 1
    case .showDefault(let newText):
        CEFStringSetFromSwiftString(newText, cefStringPtr: textPtr!)
        return 0
    }
}

func CEFDisplayHandler_on_status_message(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                         browser: UnsafeMutablePointer<cef_browser_t>?,
                                         text: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onStatusMessage(browser: CEFBrowser.fromCEF(browser)!,
                        text: CEFStringToSwiftString(text!.pointee))
}

func CEFDisplayHandler_on_console_message(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                          browser: UnsafeMutablePointer<cef_browser_t>?,
                                          logSeverity: cef_log_severity_t,
                                          message: UnsafePointer<cef_string_t>?,
                                          source: UnsafePointer<cef_string_t>?,
                                          line: Int32) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onConsoleMessage(browser: CEFBrowser.fromCEF(browser)!,
                                      logSeverity: CEFLogSeverity.fromCEF(logSeverity),
                                      message: CEFStringToSwiftString(message!.pointee),
                                      source: CEFStringToSwiftString(source!.pointee),
                                      lineNumber: Int(line))
    return action == .ignore ? 1 : 0
}

func CEFDisplayHandler_on_auto_resize(ptr: UnsafeMutablePointer<cef_display_handler_t>?,
                                      browser: UnsafeMutablePointer<cef_browser_t>?,
                                      newSize: UnsafePointer<cef_size_t>?) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onAutoResize(browser: CEFBrowser.fromCEF(browser)!,
                                  newSize: CGSize.fromCEF(newSize!.pointee))
    
    return action == .consume ? 1 : 0
}
