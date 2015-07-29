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

typealias CEFRunFileDialogCallbackMarshaller = CEFMarshaller<CEFRunFileDialogCallback>

public class CEFRunFileDialogCallback: CEFHandler, CEFMarshallable {
    typealias StructType = cef_run_file_dialog_callback_t

    public func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_run_file_dialog_callback_t> {
        return CEFRunFileDialogCallbackMarshaller.pass(self)
    }

    func marshalCallbacks(inout cefStruct: cef_run_file_dialog_callback_t) {
        cefStruct.on_file_dialog_dismissed = CEFRunFileDialogCallback_onFileDialogDismissed
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
