//
//  CEFRunFileDialogCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Called asynchronously after the file dialog is dismissed.
/// |selected_accept_filter| is the 0-based index of the value selected from
/// the accept filters array passed to CefBrowserHost::RunFileDialog.
/// |file_paths| will be a single value or a list of values depending on the
/// dialog mode. If the selection was cancelled |file_paths| will be empty.
public typealias CEFRunFileDialogCallbackOnFileDialogDismissedBlock =
    (_ filterIndex: Int, _ filePaths: [String]) -> Void

class CEFRunFileDialogCallbackBridge: CEFRunFileDialogCallback {
    let block: CEFRunFileDialogCallbackOnFileDialogDismissedBlock
    
    init(block: @escaping CEFRunFileDialogCallbackOnFileDialogDismissedBlock) {
        self.block = block
    }
    
    func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
        block(filterIndex, filePaths)
    }
}

