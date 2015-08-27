//
//  CEFContextMenuHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Implement this interface to handle context menu events. The methods of this
// class will be called on the UI thread.
///
public protocol CEFContextMenuHandler {
    
    ///
    // Called before a context menu is displayed. |params| provides information
    // about the context menu state. |model| initially contains the default
    // context menu. The |model| can be cleared to show no context menu or
    // modified to show a custom menu. Do not keep references to |params| or
    // |model| outside of this callback.
    ///
    func onBeforeContextMenu(browser: CEFBrowser,
                             frame: CEFFrame,
                             params: CEFContextMenuParams,
                             model: CEFMenuModel)

    ///
    // Called to execute a command selected from the context menu. Return true if
    // the command was handled or false for the default implementation. See
    // cef_menu_id_t for the command ids that have default implementations. All
    // user-defined command ids should be between MENU_ID_USER_FIRST and
    // MENU_ID_USER_LAST. |params| will have the same values as what was passed to
    // OnBeforeContextMenu(). Do not keep a reference to |params| outside of this
    // callback.
    ///
    func onContextMenuCommand(browser: CEFBrowser,
                              frame: CEFFrame,
                              params: CEFContextMenuParams,
                              commandID: CEFMenuID,
                              eventFlags: CEFEventFlags) -> Bool

    ///
    // Called when the context menu is dismissed irregardless of whether the menu
    // was empty or a command was selected.
    ///
    func onContextMenuDismissed(browser: CEFBrowser, frame: CEFFrame)
}

public extension CEFContextMenuHandler {

    func onBeforeContextMenu(browser: CEFBrowser,
                             frame: CEFFrame,
                             params: CEFContextMenuParams,
                             model: CEFMenuModel) {
    }
    
    func onContextMenuCommand(browser: CEFBrowser,
                              frame: CEFFrame,
                              params: CEFContextMenuParams,
                              commandID: CEFMenuID,
                              eventFlags: CEFEventFlags) -> Bool {
        return false
    }
    
    func onContextMenuDismissed(browser: CEFBrowser, frame: CEFFrame) {
    }

}

