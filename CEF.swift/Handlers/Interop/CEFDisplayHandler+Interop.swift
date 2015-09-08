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
    
    obj.onAddressChange(CEFBrowser.fromCEF(browser)!,
                        frame: CEFFrame.fromCEF(frame)!,
                        url: NSURL(string: CEFStringToSwiftString(url.memory))!)
}

func CEFDisplayHandler_on_title_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>,
                                       title: UnsafePointer<cef_string_t>) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onTitleChange(CEFBrowser.fromCEF(browser)!,
                      title: title != nil ? CEFStringToSwiftString(title.memory) : nil)
}

func CEFDisplayHandler_on_favicon_urlchange(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            urls: cef_string_list_t) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    let urlStrings: [String]? = urls != nil ? CEFStringListToSwiftArray(urls) : nil
    
    obj.onFaviconURLChange(CEFBrowser.fromCEF(browser)!,
                           iconURLs: urlStrings?.map { NSURL(string: $0)! })
}

func CEFDisplayHandler_on_fullscreen_mode_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                                 fullscreen: Int32) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFullscreenModeChange(CEFBrowser.fromCEF(browser)!, fullscreen: fullscreen != 0)
}

func CEFDisplayHandler_on_tooltip(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  textPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    var text: String? = textPtr != nil ? CEFStringToSwiftString(textPtr.memory) : nil
    let retval = obj.onTooltip(CEFBrowser.fromCEF(browser)!, text: &text)
    
    if let text = text {
        CEFStringSetFromSwiftString(text, cefString: textPtr)
    }
    
    return retval ? 1 : 0
}

func CEFDisplayHandler_on_status_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         text: UnsafePointer<cef_string_t>) {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onStatusMessage(CEFBrowser.fromCEF(browser)!,
                        text: CEFStringToSwiftString(text.memory))
}

func CEFDisplayHandler_on_console_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                          browser: UnsafeMutablePointer<cef_browser_t>,
                                          message: UnsafePointer<cef_string_t>,
                                          source: UnsafePointer<cef_string_t>,
                                          line: Int32) -> Int32 {
    guard let obj = CEFDisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onConsoleMessage(CEFBrowser.fromCEF(browser)!,
                                message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                source: source != nil ? CEFStringToSwiftString(source.memory) : nil,
                                lineNumber: Int(line)) ? 1 : 0
}

