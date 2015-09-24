//
//  RunFileDialogCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func RunFileDialogCallback_on_file_dialog_dismissed(ptr: UnsafeMutablePointer<cef_run_file_dialog_callback_t>,
                                                    filterIndex: Int32,
                                                    filePaths: cef_string_list_t) {
    guard let obj = RunFileDialogCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onFileDialogDismissed(Int(filterIndex), filePaths: CEFStringListToSwiftArray(filePaths))
}
