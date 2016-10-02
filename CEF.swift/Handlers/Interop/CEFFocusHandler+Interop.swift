//
//  CEFFocusHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFFocusHandler_on_take_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   next: Int32) {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onTakeFocus(CEFBrowser.fromCEF(browser)!, next: next != 0)
}

func CEFFocusHandler_on_set_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  source: cef_focus_source_t) -> Int32 {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onSetFocus(CEFBrowser.fromCEF(browser)!,
                                source: CEFFocusSource.fromCEF(source))
    return action == .cancel ? 1 : 0
}

func CEFFocusHandler_on_got_focus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onGotFocus(CEFBrowser.fromCEF(browser)!)
}

