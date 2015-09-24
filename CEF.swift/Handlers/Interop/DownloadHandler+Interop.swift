//
//  DownloadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func DownloadHandler_on_before_download(ptr: UnsafeMutablePointer<cef_download_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        item: UnsafeMutablePointer<cef_download_item_t>,
                                        name: UnsafePointer<cef_string_t>,
                                        callback: UnsafeMutablePointer<cef_before_download_callback_t>) {
    guard let obj = DownloadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeDownload(Browser.fromCEF(browser)!,
                         item: DownloadItem.fromCEF(item)!,
                         suggestedName: CEFStringToSwiftString(name.memory),
                         callback: BeforeDownloadCallback.fromCEF(callback)!)
}

func DownloadHandler_on_download_updated(ptr: UnsafeMutablePointer<cef_download_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         item: UnsafeMutablePointer<cef_download_item_t>,
                                         callback: UnsafeMutablePointer<cef_download_item_callback_t>) {
    guard let obj = DownloadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadUpdated(Browser.fromCEF(browser)!,
                          item: DownloadItem.fromCEF(item)!,
                          callback: DownloadItemCallback.fromCEF(callback)!)
}

