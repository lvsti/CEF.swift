//
//  CEFRunFileDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_run_file_dialog_callback_t: CEFObject {
}

class CEFRunFileDialogCallbackMarshaller: CEFMarshaller<cef_run_file_dialog_callback_t, CEFRunFileDialogCallback> {
    override init(obj: CEFRunFileDialogCallback) {
        super.init(obj: obj)
        cefStruct.on_file_dialog_dismissed = CEFRunFileDialogCallback_onFileDialogDismissed
    }
}

public class CEFRunFileDialogCallback: CEFHandler {
    func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_run_file_dialog_callback_t> {
        return CEFRunFileDialogCallbackMarshaller.pass(self)
    }
}

func CEFRunFileDialogCallback_onFileDialogDismissed(ptr: UnsafeMutablePointer<cef_run_file_dialog_callback_t>,
                                                    filterIndex: Int32,
                                                    filePaths: cef_string_list_t) {
    guard let obj = CEFRunFileDialogCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onFileDialogDismissed(Int(filterIndex), filePaths: CEFStringListToSwiftArray(filePaths))
}
