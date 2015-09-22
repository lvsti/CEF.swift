//
//  BeforeDownloadCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_before_download_callback_t: CEFObject {
}

/// Callback interface used to asynchronously continue a download.
public class BeforeDownloadCallback: Proxy<cef_before_download_callback_t> {
    
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

    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> BeforeDownloadCallback? {
        return CEFBeforeDownloadCallback(ptr: ptr)
    }
}

