//
//  CEFDevToolsMessageObserver+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 09. 08..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDevToolsMessageObserver_on_dev_tools_message(ptr: UnsafeMutablePointer<cef_dev_tools_message_observer_t>?,
                                                     browser: UnsafeMutablePointer<cef_browser_t>?,
                                                     msg: UnsafeRawPointer?,
                                                     size: size_t) -> Int32 {
    guard let obj = CEFDevToolsMessageObserverMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onDevToolsMessage(browser: CEFBrowser.fromCEF(browser)!,
                                       message: Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: msg!), count: size, deallocator: .none))
    return action == .consume ? 1 : 0
}

func CEFDevToolsMessageObserver_on_dev_tools_method_result(ptr: UnsafeMutablePointer<cef_dev_tools_message_observer_t>?,
                                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                                           msgID: Int32,
                                                           success: Int32,
                                                           result: UnsafeRawPointer?,
                                                           size: size_t) {
    guard let obj = CEFDevToolsMessageObserverMarshaller.get(ptr) else {
        return
    }
    
    obj.onDevToolsMethodResult(browser: CEFBrowser.fromCEF(browser)!,
                               messageID: Int(msgID),
                               success: success != 0,
                               result: result != nil ? Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: result!), count: size, deallocator: .none) : nil)
}

func CEFDevToolsMessageObserver_on_dev_tools_event(ptr: UnsafeMutablePointer<cef_dev_tools_message_observer_t>?,
                                                   browser: UnsafeMutablePointer<cef_browser_t>?,
                                                   method: UnsafePointer<cef_string_t>?,
                                                   params: UnsafeRawPointer?,
                                                   size: size_t) {
    guard let obj = CEFDevToolsMessageObserverMarshaller.get(ptr) else {
        return
    }
    
    obj.onDevToolsEvent(browser: CEFBrowser.fromCEF(browser)!,
                        method: CEFStringToSwiftString(method!.pointee),
                        parameters: params != nil ? Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: params!), count: size, deallocator: .none) : nil)
}

func CEFDevToolsMessageObserver_on_dev_tools_agent_attached(ptr: UnsafeMutablePointer<cef_dev_tools_message_observer_t>?,
                                                            browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFDevToolsMessageObserverMarshaller.get(ptr) else {
        return
    }
    
    obj.onDevToolsAgentAttached(browser: CEFBrowser.fromCEF(browser)!)
}

func CEFDevToolsMessageObserver_on_dev_tools_agent_detached(ptr: UnsafeMutablePointer<cef_dev_tools_message_observer_t>?,
                                                            browser: UnsafeMutablePointer<cef_browser_t>?) {
    guard let obj = CEFDevToolsMessageObserverMarshaller.get(ptr) else {
        return
    }
    
    obj.onDevToolsAgentDetached(browser: CEFBrowser.fromCEF(browser)!)
}

