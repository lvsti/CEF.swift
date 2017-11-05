//
//  CEFJSDialogHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFJSDialogHandler_on_jsdialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>?,
                                    browser: UnsafeMutablePointer<cef_browser_t>?,
                                    origin: UnsafePointer<cef_string_t>?,
                                    type: cef_jsdialog_type_t,
                                    message: UnsafePointer<cef_string_t>?,
                                    prompt: UnsafePointer<cef_string_t>?,
                                    callback: UnsafeMutablePointer<cef_jsdialog_callback_t>?,
                                    shouldSuppress: UnsafeMutablePointer<Int32>?) -> Int32 {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onJSDialog(browser: CEFBrowser.fromCEF(browser)!,
                                origin: origin != nil ? URL(string: CEFStringToSwiftString(origin!.pointee)) : nil,
                                type: CEFJSDialogType.fromCEF(type),
                                message: message != nil ? CEFStringToSwiftString(message!.pointee) : nil,
                                prompt: prompt != nil ? CEFStringToSwiftString(prompt!.pointee) : nil,
                                callback: CEFJSDialogCallback.fromCEF(callback)!)

    if case .suppress = action {
        shouldSuppress!.pointee = 1
    }
    
    return action == .showCustom || action == .consume ? 1 : 0
}

func CEFJSDialogHandler_on_before_unload_dialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>?,
                                                browser: UnsafeMutablePointer<cef_browser_t>?,
                                                message: UnsafePointer<cef_string_t>?,
                                                isReload: Int32,
                                                callback: UnsafeMutablePointer<cef_jsdialog_callback_t>?) -> Int32 {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onBeforeUnloadDialog(browser: CEFBrowser.fromCEF(browser)!,
                                          message: message != nil ? CEFStringToSwiftString(message!.pointee) : nil,
                                          isReload: isReload != 0,
                                          callback: CEFJSDialogCallback.fromCEF(callback)!)
    return action == .showCustom || action == .consume ? 1 : 0
}

func CEFJSDialogHandler_on_reset_dialog_state(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>?,
                                              browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onResetDialogState(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFJSDialogHandler_on_dialog_closed(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>?,
                                         browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onDialogClosed(browser: CEFBrowser.fromCEF(browser)!)
}

