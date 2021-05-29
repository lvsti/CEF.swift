//
//  CEFPrintHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFPrintHandler_on_print_start(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                    browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPrintStart(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFPrintHandler_on_print_settings(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                       browser: UnsafeMutablePointer<cef_browser_t>?,
                                       settings: UnsafeMutablePointer<cef_print_settings_t>?,
                                       getDefaults: Int32) {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPrintSettings(browser: CEFBrowser.fromCEF(browser)!,
                        settings: CEFPrintSettings.fromCEF(settings)!,
                        defaults: getDefaults != 0)
}

func CEFPrintHandler_on_print_dialog(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                     browser: UnsafeMutablePointer<cef_browser_t>?,
                                     hasSelection: Int32,
                                     callback: UnsafeMutablePointer<cef_print_dialog_callback_t>?) -> Int32 {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onPrintDialog(browser: CEFBrowser.fromCEF(browser)!,
                                   hasSelection: hasSelection != 0,
                                   callback: CEFPrintDialogCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFPrintHandler_on_print_job(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                  browser: UnsafeMutablePointer<cef_browser_t>?,
                                  name: UnsafePointer<cef_string_t>?,
                                  pdfPath: UnsafePointer<cef_string_t>?,
                                  callback: UnsafeMutablePointer<cef_print_job_callback_t>?) -> Int32 {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onPrintJob(browser: CEFBrowser.fromCEF(browser)!,
                                documentName: CEFStringToSwiftString(name!.pointee),
                                pdfFilePath: CEFStringToSwiftString(pdfPath!.pointee),
                                callback: CEFPrintJobCallback.fromCEF(callback)!)
    return action == .allow ? 1 : 0
}

func CEFPrintHandler_on_print_reset(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                    browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPrintReset(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFPrintHandler_get_pdf_paper_size(ptr: UnsafeMutablePointer<cef_print_handler_t>?,
                                        browser: UnsafeMutablePointer<cef_browser_t>?,
                                        dpi: Int32) -> cef_size_t {
    guard let obj = CEFPrintHandlerMarshaller.get(ptr) else {
        return cef_size_t()
    }
    
    let size = obj.pdfPaperSize(browser: CEFBrowser.fromCEF(browser)!, forDeviceUnitsPerInch: Int(dpi))
    return size.toCEF()
}


