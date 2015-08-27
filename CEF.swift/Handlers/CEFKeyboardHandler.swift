//
//  CEFKeyboardHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to handle events related to keyboard input. The
/// methods of this class will be called on the UI thread.
public protocol CEFKeyboardHandler {
    
    // Called before a keyboard event is sent to the renderer. |event| contains
    // information about the keyboard event. |os_event| is the operating system
    // event message, if any. Return true if the event was handled or false
    // otherwise. If the event will be handled in OnKeyEvent() as a keyboard
    // shortcut set |is_keyboard_shortcut| to true and return false.
    func onPreKeyEvent(browser: CEFBrowser,
                       event: CEFKeyEvent,
                       osEvent: CEFEventHandle,
                       inout isShortcut: Bool) -> Bool
    
    /// Called after the renderer and JavaScript in the page has had a chance to
    /// handle the event. |event| contains information about the keyboard event.
    /// |os_event| is the operating system event message, if any. Return true if
    /// the keyboard event was handled or false otherwise.
    func onKeyEvent(browser: CEFBrowser, event: CEFKeyEvent, osEvent: CEFEventHandle) -> Bool

}

public extension CEFKeyboardHandler {
    
    func onPreKeyEvent(browser: CEFBrowser,
                       event: CEFKeyEvent,
                       osEvent: CEFEventHandle,
                       inout isShortcut: Bool) -> Bool {
        return false
    }
    
    func onKeyEvent(browser: CEFBrowser, event: CEFKeyEvent, osEvent: CEFEventHandle) -> Bool {
        return false
    }
    
}

