//
//  CEFBeforeDownloadCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFBeforeDownloadCallback {
    
    /// Call to continue the download. Set |download_path| to the full file path
    /// for the download including the file name or leave blank to use the
    /// suggested name and the default temp directory. Set |show_dialog| to true
    /// if you do wish to show the default "Save As" dialog.
    public func doContinue(downloadPath: String?, showDialog: Bool) {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            downloadPath != nil ? CEFStringPtrCreateFromSwiftString(downloadPath!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        
        cefObject.cont(cefObjectPtr, cefStrPtr, showDialog ? 1 : 0)
    }

}

