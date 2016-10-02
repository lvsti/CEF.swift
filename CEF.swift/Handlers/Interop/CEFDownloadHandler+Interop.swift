//
//  CEFDownloadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDownloadHandler_on_before_download(ptr: UnsafeMutablePointer<cef_download_handler_t>,
                                           browser: UnsafeMutablePointer<cef_browser_t>,
                                           item: UnsafeMutablePointer<cef_download_item_t>,
                                           name: UnsafePointer<cef_string_t>,
                                           callback: UnsafeMutablePointer<cef_before_download_callback_t>) {
    guard let obj = CEFDownloadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeDownload(CEFBrowser.fromCEF(browser)!,
                         item: CEFDownloadItem.fromCEF(item)!,
                         suggestedName: CEFStringToSwiftString(name.pointee),
                         callback: CEFBeforeDownloadCallback.fromCEF(callback)!)
}

func CEFDownloadHandler_on_download_updated(ptr: UnsafeMutablePointer<cef_download_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            item: UnsafeMutablePointer<cef_download_item_t>,
                                            callback: UnsafeMutablePointer<cef_download_item_callback_t>) {
    guard let obj = CEFDownloadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadUpdated(CEFBrowser.fromCEF(browser)!,
                          item: CEFDownloadItem.fromCEF(item)!,
                          callback: CEFDownloadItemCallback.fromCEF(callback)!)
}

