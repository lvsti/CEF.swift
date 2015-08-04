//
//  CEFContextMenuHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFContextMenuHandler {
    
    func onBeforeContextMenu(browser: CEFBrowser,
                             frame: CEFFrame,
                             params: CEFContextMenuParams,
                             model: CEFMenuModel)
    func onContextMenuCommand(browser: CEFBrowser,
                              frame: CEFFrame,
                              params: CEFContextMenuParams,
                              commandID: Int,
                              eventFlags: CEFEventFlags) -> Bool
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
                              commandID: Int,
                              eventFlags: CEFEventFlags) -> Bool {
        return false
    }
    
    func onContextMenuDismissed(browser: CEFBrowser, frame: CEFFrame) {
    }

}

