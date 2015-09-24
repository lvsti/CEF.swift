//
//  JSDialogHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func JSDialogHandler_on_jsdialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 origin: UnsafePointer<cef_string_t>,
                                 acceptLanguage: UnsafePointer<cef_string_t>,
                                 type: cef_jsdialog_type_t,
                                 message: UnsafePointer<cef_string_t>,
                                 prompt: UnsafePointer<cef_string_t>,
                                 callback: UnsafeMutablePointer<cef_jsdialog_callback_t>,
                                 shouldSuppress: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = JSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    let action = obj.onJSDialog(Browser.fromCEF(browser)!,
                                origin: origin != nil ? NSURL(string: CEFStringToSwiftString(origin.memory)) : nil,
                                acceptLanguage: acceptLanguage != nil ? CEFStringToSwiftString(acceptLanguage.memory) : nil,
                                type: JSDialogType.fromCEF(type),
                                message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                prompt: prompt != nil ? CEFStringToSwiftString(prompt.memory) : nil,
                                callback: JSDialogCallback.fromCEF(callback)!)

    if case .Suppress = action {
        shouldSuppress.memory = 1
    }
    
    return action ? 1 : 0
}

func JSDialogHandler_on_before_unload_dialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                             browser: UnsafeMutablePointer<cef_browser_t>,
                                             message: UnsafePointer<cef_string_t>,
                                             isReload: Int32,
                                             callback: UnsafeMutablePointer<cef_jsdialog_callback_t>) -> Int32 {
    guard let obj = JSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onBeforeUnloadDialog(Browser.fromCEF(browser)!,
                                    message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                    isReload: isReload != 0,
                                    callback: JSDialogCallback.fromCEF(callback)!) ? 1 : 0
}

func JSDialogHandler_on_reset_dialog_state(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                           browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = JSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onResetDialogState(Browser.fromCEF(browser)!)
}

func JSDialogHandler_on_dialog_closed(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = JSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onDialogClosed(Browser.fromCEF(browser)!)
}

