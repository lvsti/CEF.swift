//
//  CEFJSDialogHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_jsdialog_handler_t: CEFObject {
}

typealias CEFJSDialogHandlerMarshaller = CEFMarshaller<CEFJSDialogHandler, cef_jsdialog_handler_t>

extension CEFJSDialogHandler {
    func toCEF() -> UnsafeMutablePointer<cef_jsdialog_handler_t> {
        return CEFJSDialogHandlerMarshaller.pass(self)
    }
}

extension cef_jsdialog_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_jsdialog = CEFJSDialogHandler_onJSDialog
        on_before_unload_dialog = CEFJSDialogHandler_onBeforeUnloadDialog
        on_reset_dialog_state = CEFJSDialogHandler_onResetDialogState
        on_dialog_closed = CEFJSDialogHandler_onDialogClosed
    }
}


func CEFJSDialogHandler_onJSDialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   origin: UnsafePointer<cef_string_t>,
                                   acceptLanguage: UnsafePointer<cef_string_t>,
                                   type: cef_jsdialog_type_t,
                                   message: UnsafePointer<cef_string_t>,
                                   prompt: UnsafePointer<cef_string_t>,
                                   callback: UnsafeMutablePointer<cef_jsdialog_callback_t>,
                                   shouldSuppress: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    var suppress = false
    let retval = obj.onJSDialog(CEFBrowser.fromCEF(browser)!,
                                origin: origin != nil ? NSURL(string: CEFStringToSwiftString(origin.memory)) : nil,
                                acceptLanguage: acceptLanguage != nil ? CEFStringToSwiftString(acceptLanguage.memory) : nil,
                                type: CEFJSDialogType.fromCEF(type),
                                message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                prompt: prompt != nil ? CEFStringToSwiftString(prompt.memory) : nil,
                                callback: CEFJSDialogCallback.fromCEF(callback)!,
                                shouldSuppress: &suppress)
    if shouldSuppress != nil {
        shouldSuppress.memory = suppress ? 1 : 0
    }
    
    return retval ? 1 : 0
}

func CEFJSDialogHandler_onBeforeUnloadDialog(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                             browser: UnsafeMutablePointer<cef_browser_t>,
                                             message: UnsafePointer<cef_string_t>,
                                             isReload: Int32,
                                             callback: UnsafeMutablePointer<cef_jsdialog_callback_t>) -> Int32 {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onBeforeUnloadDialog(CEFBrowser.fromCEF(browser)!,
                                    message: message != nil ? CEFStringToSwiftString(message.memory) : nil,
                                    isReload: isReload != 0,
                                    callback: CEFJSDialogCallback.fromCEF(callback)!) ? 1 : 0
}

func CEFJSDialogHandler_onResetDialogState(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                           browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onResetDialogState(CEFBrowser.fromCEF(browser)!)
}

func CEFJSDialogHandler_onDialogClosed(ptr: UnsafeMutablePointer<cef_jsdialog_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFJSDialogHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onDialogClosed(CEFBrowser.fromCEF(browser)!)
}

