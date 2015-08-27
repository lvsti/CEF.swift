//
//  CEFFileDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_file_dialog_callback_t: CEFObject {
}

/// Callback interface for asynchronous continuation of file dialog requests.
public class CEFFileDialogCallback: CEFProxy<cef_file_dialog_callback_t> {
    
    /// Continue the file selection. |selected_accept_filter| should be the 0-based
    /// index of the value selected from the accept filters array passed to
    /// CefDialogHandler::OnFileDialog. |file_paths| should be a single value or a
    /// list of values depending on the dialog mode. An empty |file_paths| value is
    /// treated the same as calling Cancel().
    func doContinue(selectedFilterIndex: Int, paths: [String]) {
        let cefList = CEFStringListCreateFromSwiftArray(paths)
        defer { CEFStringListRelease(cefList) }
        cefObject.cont(cefObjectPtr, Int32(selectedFilterIndex), cefList)
    }
    
    /// Cancel the file selection.
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFFileDialogCallback? {
        return CEFFileDialogCallback(ptr: ptr)
    }
    
}
