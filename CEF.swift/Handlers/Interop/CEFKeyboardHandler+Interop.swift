//
//  CEFKeyboardHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFKeyboardHandler_on_pre_key_event(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         event: UnsafePointer<cef_key_event_t>,
                                         osEvent: UnsafeMutablePointer<Void>,
                                         isShortcut: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFKeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onPreKeyEvent(CEFBrowser.fromCEF(browser)!,
                                   event: CEFKeyEvent.fromCEF(event.pointee),
                                   osEvent: Unmanaged<CEFEventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue())
    if case .PassAsShortcut = action {
        isShortcut.pointee = 1
    }
    
    return action ? 1 : 0
}

func CEFKeyboardHandler_on_key_event(ptr: UnsafeMutablePointer<cef_keyboard_handler_t>,
                                     browser: UnsafeMutablePointer<cef_browser_t>,
                                     event: UnsafePointer<cef_key_event_t>,
                                     osEvent: UnsafeMutablePointer<Void>) -> Int32 {
    guard let obj = CEFKeyboardHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let retval = obj.onKeyEvent(CEFBrowser.fromCEF(browser)!,
                                event: CEFKeyEvent.fromCEF(event.pointee),
                                osEvent: Unmanaged<CEFEventHandle>.fromOpaque(COpaquePointer(osEvent)).takeUnretainedValue())
    
    return retval ? 1 : 0
}

