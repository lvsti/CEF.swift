//
//  CEFRunFileDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefBrowserHost::RunFileDialog. The methods of this
/// class will be called on the browser process UI thread.
public protocol CEFRunFileDialogCallback {

    /// Called asynchronously after the file dialog is dismissed.
    /// |selected_accept_filter| is the 0-based index of the value selected from
    /// the accept filters array passed to CefBrowserHost::RunFileDialog.
    /// |file_paths| will be a single value or a list of values depending on the
    /// dialog mode. If the selection was cancelled |file_paths| will be empty.
    func onFileDialogDismissed(filterIndex: Int, filePaths: [String])

}


public extension CEFRunFileDialogCallback {
    
    public func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
    }
    
}

