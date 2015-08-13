//
//  CEFKeyboardHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_keyboard_handler_t: CEFObject {
}

typealias CEFKeyboardHandlerMarshaller = CEFMarshaller<CEFKeyboardHandler, cef_keyboard_handler_t>

extension CEFKeyboardHandler {
    func toCEF() -> UnsafeMutablePointer<cef_keyboard_handler_t> {
        return CEFKeyboardHandlerMarshaller.pass(self)
    }
}

extension cef_keyboard_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_pre_key_event = CEFKeyboardHandler_onPreKeyEvent
        on_key_event = CEFKeyboardHandler_onKeyEvent
    }
}

func CEFKeyboardHandler_onPreKeyEvent(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      event: UnsafePointer<cef_key_event_t>,
                                      osEvent: UnsafeMutablePointer<Void>,
                                      isShortcut: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFKeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var flag = false
    let retval = obj.onPreKeyEvent(CEFBrowser.fromCEF(browser)!,
                                   event: CEFKeyEvent.fromCEF(event.memory),
                                   osEvent: Unmanaged<CEFEventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue(),
                                   isShortcut: &flag)
    if isShortcut != nil {
        isShortcut.memory = flag ? 1 : 0
    }
    
    return retval ? 1 : 0
}

func CEFKeyboardHandler_onKeyEvent(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   event: UnsafePointer<cef_key_event_t>,
                                   osEvent: UnsafeMutablePointer<Void>) -> Int32 {
    guard let obj = CEFKeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let retval = obj.onKeyEvent(CEFBrowser.fromCEF(browser)!,
                                event: CEFKeyEvent.fromCEF(event.memory),
                                osEvent: Unmanaged<CEFEventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue())
    
    return retval ? 1 : 0
}

