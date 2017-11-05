//
//  CEFDownloadImageCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefBrowserHost::DownloadImage. The methods of this
/// class will be called on the browser process UI thread.
/// CEF name: `CefDownloadImageCallback`
public protocol CEFDownloadImageCallback {
    
    /// Method that will be executed when the image download has completed.
    /// |image_url| is the URL that was downloaded and |http_status_code| is the
    /// resulting HTTP status code. |image| is the resulting image, possibly at
    /// multiple scale factors, or empty if the download failed.
    /// CEF name: `OnDownloadImageFinished`
    func onDownloadImageFinished(url: URL, statusCode: Int, image: CEFImage?)
    
}


public extension CEFDownloadImageCallback {
    
    func onDownloadImageFinished(url: URL, statusCode: Int, image: CEFImage?) {
    }
    
}
