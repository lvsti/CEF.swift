//
//  CEFDownloadItemCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


extension cef_download_item_callback_t: CEFObject {
}

///
// Callback interface used to asynchronously cancel a download.
///
public class CEFDownloadItemCallback: CEFProxy<cef_download_item_callback_t> {
    
    ///
    // Call to cancel the download.
    ///
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    ///
    // Call to pause the download.
    ///
    public func doPause() {
        cefObject.pause(cefObjectPtr)
    }
    
    ///
    // Call to resume the download.
    ///
    public func doResume() {
        cefObject.resume(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDownloadItemCallback? {
        return CEFDownloadItemCallback(ptr: ptr)
    }
}

