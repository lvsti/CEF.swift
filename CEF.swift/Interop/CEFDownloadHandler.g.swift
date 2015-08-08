//
//  CEFDownloadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_download_handler_t: CEFObject {
}

typealias CEFDownloadHandlerMarshaller = CEFMarshaller<CEFDownloadHandler, cef_download_handler_t>

extension CEFDownloadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_download_handler_t> {
        return CEFDownloadHandlerMarshaller.pass(self)
    }
}

extension cef_download_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_download = CEFDownloadHandler_onBeforeDownload
        on_download_updated = CEFDownloadHandler_onDownloadUpdated
    }
}


func CEFDownloadHandler_onBeforeDownload(ptr: UnsafeMutablePointer<cef_download_handler_t>,
                                         browser: UnsafeMutablePointer<cef_browser_t>,
                                         item: UnsafeMutablePointer<cef_download_item_t>,
                                         name: UnsafePointer<cef_string_t>,
                                         callback: UnsafeMutablePointer<cef_before_download_callback_t>) {
    guard let obj = CEFDownloadHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeDownload(CEFBrowser.fromCEF(browser)!,
                         item: CEFDownloadItem.fromCEF(item)!,
                         suggestedName: CEFStringToSwiftString(name.memory),
                         callback: CEFBeforeDownloadCallback.fromCEF(callback)!)
}

func CEFDownloadHandler_onDownloadUpdated(ptr: UnsafeMutablePointer<cef_download_handler_t>,
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

