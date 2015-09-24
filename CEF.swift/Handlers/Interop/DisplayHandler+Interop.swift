//
//  DisplayHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func DisplayHandler_on_address_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      frame: UnsafeMutablePointer<cef_frame_t>,
                                      url: UnsafePointer<cef_string_t>) {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAddressChange(Browser.fromCEF(browser)!,
                        frame: Frame.fromCEF(frame)!,
                        url: NSURL(string: CEFStringToSwiftString(url.memory))!)
}

func DisplayHandler_on_title_change(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    title: UnsafePointer<cef_string_t>) {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onTitleChange(Browser.fromCEF(browser)!,
                      title: title != nil ? CEFStringToSwiftString(title.memory) : nil)
}

func DisplayHandler_on_favicon_urlchange(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         urls: cef_string_list_t) {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return
    }
    
    let urlStrings: [String]? = urls != nil ? CEFStringListToSwiftArray(urls) : nil
    
    obj.onFaviconURLChange(Browser.fromCEF(browser)!,
                           iconURLs: urlStrings?.map { NSURL(string: $0)! })
}

func DisplayHandler_on_tooltip(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>,
                               textPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    var text: String? = textPtr != nil ? CEFStringToSwiftString(textPtr.memory) : nil
    let retval = obj.onTooltip(Browser.fromCEF(browser)!, text: &text)
    
    if let text = text {
        CEFStringSetFromSwiftString(text, cefString: textPtr)
    }
    
    return retval ? 1 : 0
}

func DisplayHandler_on_status_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      text: UnsafePointer<cef_string_t>) {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onStatusMessage(Browser.fromCEF(browser)!,
                        text: CEFStringToSwiftString(text.memory))
}

func DisplayHandler_on_console_message(ptr: UnsafeMutablePointer<cef_display_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>,
                                       message: UnsafePointer<cef_string_t>,
                                       source: UnsafePointer<cef_string_t>,
                                       line: Int32) -> Int32 {
    guard let obj = DisplayHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onConsoleMessage(Browser.fromCEF(browser)!,
                                message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                source: source != nil ? CEFStringToSwiftString(source.memory) : nil,
                                lineNumber: Int(line)) ? 1 : 0
}

