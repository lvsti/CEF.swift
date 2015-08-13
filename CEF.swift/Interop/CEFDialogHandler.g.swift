//
//  CEFDialogHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_dialog_handler_t: CEFObject {
}

typealias CEFDialogHandlerMarshaller = CEFMarshaller<CEFDialogHandler, cef_dialog_handler_t>

extension CEFDialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_dialog_handler_t> {
        return CEFDialogHandlerMarshaller.pass(self)
    }
}

extension cef_dialog_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_file_dialog = CEFDialogHandler_onFileDialog
    }
}


func CEFDialogHandler_onFileDialog(ptr: UnsafeMutablePointer<cef_dialog_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   mode: cef_file_dialog_mode_t,
                                   title: UnsafePointer<cef_string_t>,
                                   path: UnsafePointer<cef_string_t>,
                                   filters: cef_string_list_t,
                                   selectedIndex: Int32,
                                   callback: UnsafeMutablePointer<cef_file_dialog_callback_t>) -> Int32 {
    guard let obj = CEFDialogHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onFileDialog(CEFBrowser.fromCEF(browser)!,
                            mode: CEFFileDialogMode.fromCEF(mode),
                            title: title != nil ? CEFStringToSwiftString(title.memory) : nil,
                            defaultPath: path != nil ? CEFStringToSwiftString(path.memory) : nil,
                            acceptFilters: CEFStringListToSwiftArray(filters),
                            selectedFilterIndex: Int(selectedIndex),
                            callback: CEFFileDialogCallback.fromCEF(callback)!) ? 1 : 0
}
