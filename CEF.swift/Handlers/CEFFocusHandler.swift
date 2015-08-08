//
//  CEFFocusHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Implement this interface to handle events related to focus. The methods of
// this class will be called on the UI thread.
///
public protocol CEFFocusHandler {

    ///
    // Called when the browser component is about to loose focus. For instance, if
    // focus was on the last HTML element and the user pressed the TAB key. |next|
    // will be true if the browser is giving focus to the next component and false
    // if the browser is giving focus to the previous component.
    ///
    func onTakeFocus(browser: CEFBrowser, next: Bool)
    
    ///
    // Called when the browser component is requesting focus. |source| indicates
    // where the focus request is originating from. Return false to allow the
    // focus to be set or true to cancel setting the focus.
    ///
    func onSetFocus(browser: CEFBrowser, source: CEFFocusSource) -> Bool
    
    ///
    // Called when the browser component has received focus.
    ///
    func onGotFocus(browser: CEFBrowser)

}

public extension CEFFocusHandler {

    func onTakeFocus(browser: CEFBrowser, next: Bool) {
    }
    
    func onSetFocus(browser: CEFBrowser, source: CEFFocusSource) -> Bool {
        return false
    }
    
    func onGotFocus(browser: CEFBrowser) {
    }

}

