//
//  CEFRequestContextHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRequestContextHandler_get_cookie_manager(ptr: UnsafeMutablePointer<cef_request_context_handler_t>) -> UnsafeMutablePointer<cef_cookie_manager_t> {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return nil
    }

    if let manager = obj.cookieManager {
        return manager.toCEF()
    }
    
    return nil
}

func CEFRequestContextHandler_on_before_plugin_load(ptr: UnsafeMutablePointer<cef_request_context_handler_t>,
                                                    mimeType: UnsafePointer<cef_string_t>,
                                                    pluginURL: UnsafePointer<cef_string_t>,
                                                    topOriginURL: UnsafePointer<cef_string_t>,
                                                    pluginInfo: UnsafeMutablePointer<cef_web_plugin_info_t>,
                                                    pluginPolicy: UnsafeMutablePointer<cef_plugin_policy_t>) -> Int32 {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return 0
    }

    let result = obj.onBeforePluginLoad(CEFStringToSwiftString(mimeType.memory),
                                        pluginURL: pluginURL != nil ? NSURL(string: CEFStringToSwiftString(pluginURL.memory)) : nil,
                                        topOriginURL: topOriginURL != nil ? NSURL(string: CEFStringToSwiftString(topOriginURL.memory)) : nil,
                                        pluginInfo: CEFWebPluginInfo.fromCEF(pluginInfo)!,
                                        defaultPolicy: CEFPluginPolicy.fromCEF(pluginPolicy.memory))
    
    if case .OverridePolicy(let policy) = result {
        pluginPolicy.memory = policy.toCEF()
        return 1
    }
    
    return 0
}

