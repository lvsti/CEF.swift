//
//  DialogHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func DialogHandler_on_file_dialog(ptr: UnsafeMutablePointer<cef_dialog_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  mode: cef_file_dialog_mode_t,
                                  title: UnsafePointer<cef_string_t>,
                                  path: UnsafePointer<cef_string_t>,
                                  filters: cef_string_list_t,
                                  selectedIndex: Int32,
                                  callback: UnsafeMutablePointer<cef_file_dialog_callback_t>) -> Int32 {
    guard let obj = DialogHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onFileDialog(Browser.fromCEF(browser)!,
                            mode: FileDialogMode.fromCEF(mode),
                            title: title != nil ? CEFStringToSwiftString(title.memory) : nil,
                            defaultPath: path != nil ? CEFStringToSwiftString(path.memory) : nil,
                            acceptFilters: CEFStringListToSwiftArray(filters),
                            selectedFilterIndex: Int(selectedIndex),
                            callback: FileDialogCallback.fromCEF(callback)!) ? 1 : 0
}
