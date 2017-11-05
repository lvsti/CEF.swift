//
//  CEFExtensionHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 02..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFExtensionHandler_on_extension_load_failed(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                                  errorCode: cef_errorcode_t) {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onExtensionLoadFailed(errorCode: CEFErrorCode.fromCEF(errorCode.rawValue))
}

func CEFExtensionHandler_on_extension_loaded(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                             ext: UnsafeMutablePointer<cef_extension_t>?) {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onExtensionLoaded(extension: CEFExtension.fromCEF(ext)!)
}

func CEFExtensionHandler_on_extension_unloaded(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                               ext: UnsafeMutablePointer<cef_extension_t>?) {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onExtensionUnloaded(extension: CEFExtension.fromCEF(ext)!)
}

func CEFExtensionHandler_on_before_background_browser(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                                      ext: UnsafeMutablePointer<cef_extension_t>?,
                                                      href: UnsafePointer<cef_string_t>?,
                                                      cefClient: UnsafeMutablePointer<UnsafeMutablePointer<cef_client_t>?>?,
                                                      cefSettings: UnsafeMutablePointer<cef_browser_settings_t>?) -> Int32 {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var client = CEFClientMarshaller.take(cefClient!.pointee)!
    var settings = CEFBrowserSettings.fromCEF(cefSettings!.pointee)

    let action = obj.onBeforeBackgroundBrowser(extension: CEFExtension.fromCEF(ext)!,
                                               href: CEFStringToSwiftString(href!.pointee),
                                               client: &client,
                                               settings: &settings)
    
    cefClient!.pointee = CEFClientMarshaller.pass(client)
    cefSettings!.pointee = settings.toCEF()

    return action == .cancel ? 1 : 0
}

func CEFExtensionHandler_on_before_browser(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                           ext: UnsafeMutablePointer<cef_extension_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           activeBrowser: UnsafeMutablePointer<cef_browser_t>?,
                                           index: Int32,
                                           url: UnsafePointer<cef_string_t>?,
                                           activate: Int32,
                                           windowInfo: UnsafeMutablePointer<cef_window_info_t>?,
                                           cefClient: UnsafeMutablePointer<UnsafeMutablePointer<cef_client_t>?>?,
                                           cefSettings: UnsafeMutablePointer<cef_browser_settings_t>?) -> Int32 {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var winInfo = CEFWindowInfo.fromCEF(windowInfo!.pointee)
    var client = CEFClientMarshaller.take(cefClient!.pointee)!
    var settings = CEFBrowserSettings.fromCEF(cefSettings!.pointee)
    
    let action = obj.onBeforeBrowser(extension: CEFExtension.fromCEF(ext)!,
                                     browser: CEFBrowser.fromCEF(browser)!,
                                     activeBrowser: CEFBrowser.fromCEF(activeBrowser)!,
                                     index: Int(index),
                                     url: URL(string: CEFStringToSwiftString(url!.pointee))!,
                                     activateOnOpen: activate != 0,
                                     windowInfo: &winInfo,
                                     client: &client,
                                     settings: &settings)
    
    windowInfo!.pointee = winInfo.toCEF()
    cefClient!.pointee = CEFClientMarshaller.pass(client)
    cefSettings!.pointee = settings.toCEF()
    
    return action == .cancel ? 1 : 0
}

func CEFExtensionHandler_get_active_browser(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                            ext: UnsafeMutablePointer<cef_extension_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            includeIncognito: Int32) -> UnsafeMutablePointer<cef_browser_t>? {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return nil
    }
    
    let browser = obj.activeBrowser(for: CEFExtension.fromCEF(ext)!,
                                    browser: CEFBrowser.fromCEF(browser)!,
                                    includeIncognito: includeIncognito != 0)
    return browser?.toCEF()
}

func CEFExtensionHandler_can_access_browser(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                            ext: UnsafeMutablePointer<cef_extension_t>?,
                                            browser: UnsafeMutablePointer<cef_browser_t>?,
                                            includeIncognito: Int32,
                                            targetBrowser: UnsafeMutablePointer<cef_browser_t>?) -> Int32 {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.canAccessBrowser(for: CEFExtension.fromCEF(ext)!,
                                browser: CEFBrowser.fromCEF(browser)!,
                                includeIncognito: includeIncognito != 0,
                                targetBrowser: CEFBrowser.fromCEF(targetBrowser)!) ? 1 : 0
}

func CEFExtensionHandler_get_extension_resource(ptr: UnsafeMutablePointer<cef_extension_handler_t>?,
                                                ext: UnsafeMutablePointer<cef_extension_t>?,
                                                browser: UnsafeMutablePointer<cef_browser_t>?,
                                                path: UnsafePointer<cef_string_t>?,
                                                callback: UnsafeMutablePointer<cef_get_extension_resource_callback_t>?) -> Int32 {
    guard let obj = CEFExtensionHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onGetExtensionResource(for: CEFExtension.fromCEF(ext)!,
                                            browser: CEFBrowser.fromCEF(browser)!,
                                            filePath: CEFStringToSwiftString(path!.pointee),
                                            callback: CEFGetExtensionResourceCallback.fromCEF(callback)!)
    return action == .performCustom ? 1 : 0
}

