//
//  CEFRunContextMenuCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 10. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension CEFRunContextMenuCallback {
    
    /// Complete context menu display by selecting the specified |command_id| and
    /// |event_flags|.
    public func doContinue(commandID: CEFMenuID, eventFlags: CEFEventFlags) {
        cefObject.cont(cefObjectPtr, commandID.toCEF(), eventFlags.toCEF())
    }
    
    /// Cancel context menu display.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

}
