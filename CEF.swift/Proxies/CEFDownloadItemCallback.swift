//
//  CEFDownloadItemCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDownloadItemCallback {
    
    /// Call to cancel the download.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    /// Call to pause the download.
    public func doPause() {
        cefObject.pause(cefObjectPtr)
    }
    
    /// Call to resume the download.
    public func doResume() {
        cefObject.resume(cefObjectPtr)
    }
    
}

