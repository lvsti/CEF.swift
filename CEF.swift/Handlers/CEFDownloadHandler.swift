//
//  CEFDownloadHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class used to handle file downloads. The methods of this class will called
/// on the browser process UI thread.
/// CEF name: `CefDownloadHandler`
public protocol CEFDownloadHandler {
    
    /// Called before a download begins. |suggested_name| is the suggested name for
    /// the download file. By default the download will be canceled. Execute
    /// |callback| either asynchronously or in this method to continue the download
    /// if desired. Do not keep a reference to |download_item| outside of this
    /// method.
    /// CEF name: `OnBeforeDownload`
    func onBeforeDownload(browser: CEFBrowser,
                          item: CEFDownloadItem,
                          suggestedName: String,
                          callback: CEFBeforeDownloadCallback)
    
    /// Called when a download's status or progress information has been updated.
    /// This may be called multiple times before and after OnBeforeDownload().
    /// Execute |callback| either asynchronously or in this method to cancel the
    /// download if desired. Do not keep a reference to |download_item| outside of
    /// this method.
    /// CEF name: `OnDownloadUpdated`
    func onDownloadUpdated(browser: CEFBrowser,
                           item: CEFDownloadItem,
                           callback: CEFDownloadItemCallback)
    
}

public extension CEFDownloadHandler {
    
    func onBeforeDownload(browser: CEFBrowser,
                          item: CEFDownloadItem,
                          suggestedName: String,
                          callback: CEFBeforeDownloadCallback) {
    }
    
    func onDownloadUpdated(browser: CEFBrowser,
                           item: CEFDownloadItem,
                           callback: CEFDownloadItemCallback) {
    }
    
}

