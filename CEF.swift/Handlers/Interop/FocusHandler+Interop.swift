//
//  FocusHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func FocusHandler_on_take_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                browser: UnsafeMutablePointer<cef_browser_t>,
                                next: Int32) {
    guard let obj = FocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onTakeFocus(Browser.fromCEF(browser)!, next: next != 0)
}

func FocusHandler_on_set_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>,
                               source: cef_focus_source_t) -> Int32 {
    guard let obj = FocusHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onSetFocus(Browser.fromCEF(browser)!,
                          source: FocusSource.fromCEF(source)) ? 1 : 0
}

func FocusHandler_on_got_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = FocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onGotFocus(Browser.fromCEF(browser)!)
}

