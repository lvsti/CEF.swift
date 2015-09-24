//
//  KeyboardHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func KeyboardHandler_on_pre_key_event(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      event: UnsafePointer<cef_key_event_t>,
                                      osEvent: UnsafeMutablePointer<Void>,
                                      isShortcut: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = KeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onPreKeyEvent(Browser.fromCEF(browser)!,
                                   event: KeyEvent.fromCEF(event.memory),
                                   osEvent: Unmanaged<EventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue())
    if case .PassAsShortcut = action {
        isShortcut.memory = 1
    }
    
    return action ? 1 : 0
}

func KeyboardHandler_on_key_event(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  event: UnsafePointer<cef_key_event_t>,
                                  osEvent: UnsafeMutablePointer<Void>) -> Int32 {
    guard let obj = KeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let retval = obj.onKeyEvent(Browser.fromCEF(browser)!,
                                event: KeyEvent.fromCEF(event.memory),
                                osEvent: Unmanaged<EventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue())
    
    return retval ? 1 : 0
}

