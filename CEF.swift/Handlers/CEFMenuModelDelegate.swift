//
//  CEFMenuModelDelegate.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to handle menu model events. The methods of this
/// class will be called on the browser process UI thread unless otherwise
/// indicated.
/// CEF name: `CefMenuModelDelegate`
public protocol CEFMenuModelDelegate {

    /// Perform the action associated with the specified |command_id| and
    /// optional |event_flags|.
    /// CEF name: `ExecuteCommand`
    func onExecuteCommand(menuModel: CEFMenuModel, commandID: CEFMenuID, eventFlags: CEFEventFlags)
    
    /// Called when the user moves the mouse outside the menu and over the owning
    /// window.
    /// CEF name: `MouseOutsideMenu`
    func onMouseOutsideMenu(menuModel: CEFMenuModel, at point: NSPoint)
    
    /// Called on unhandled open submenu keyboard commands. |is_rtl| will be true
    /// if the menu is displaying a right-to-left language.
    /// CEF name: `UnhandledOpenSubmenu`
    func onUnhandledOpenSubmenu(menuModel: CEFMenuModel, isRTL: Bool)
    
    /// Called on unhandled close submenu keyboard commands. |is_rtl| will be true
    /// if the menu is displaying a right-to-left language.
    /// CEF name: `UnhandledCloseSubmenu`
    func onUnhandledCloseSubmenu(menuModel: CEFMenuModel, isRTL: Bool)
    
    /// The menu is about to show.
    /// CEF name: `MenuWillShow`
    func onMenuWillShow(menuModel: CEFMenuModel)
    
    /// The menu has closed.
    /// CEF name: `MenuClosed`
    func onMenuClosed(menuModel: CEFMenuModel)
    
    /// Optionally modify a menu item label. Return true if |label| was modified.
    /// CEF name: `FormatLabel`
    func onFormatLabel(menuModel: CEFMenuModel, label: String) -> String?

}

public extension CEFMenuModelDelegate {
    
    func onExecuteCommand(menuModel: CEFMenuModel, commandID: CEFMenuID, eventFlags: CEFEventFlags) {
    }
    
    func onMouseOutsideMenu(menuModel: CEFMenuModel, at point: NSPoint) {
    }
    
    func onUnhandledOpenSubmenu(menuModel: CEFMenuModel, isRTL: Bool) {
    }
    
    func onUnhandledCloseSubmenu(menuModel: CEFMenuModel, isRTL: Bool) {
    }

    func onMenuWillShow(menuModel: CEFMenuModel) {
    }
    
    func onMenuClosed(menuModel: CEFMenuModel) {
    }
    
    func onFormatLabel(menuModel: CEFMenuModel, label: String) -> String? {
        return nil
    }

}

