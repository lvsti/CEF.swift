//
//  CEFMessageRouterConfig.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 06..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper

/// Used to configure the query router. The same values must be passed to both
/// CefMessageRouterBrowserSide and CefMessageRouterRendererSide. If using
/// multiple router pairs make sure to choose values that do not conflict.
/// CEF name: `CefMessageRouterConfig`
public struct CEFMessageRouterConfig {
    /// Name of the JavaScript function that will be added to the 'window' object
    /// for sending a query. The default value is "cefQuery".
    /// CEF name: `js_query_function`
    public var jsQueryFunction: String
    
    /// Name of the JavaScript function that will be added to the 'window' object
    /// for canceling a pending query. The default value is "cefQueryCancel".
    /// CEF name: `js_cancel_function`
    public var jsCancelFunction: String

    public init(jsQueryFunction: String = "cefQuery", jsCancelFunction: String = "cefQueryCancel") {
        self.jsQueryFunction = jsQueryFunction
        self.jsCancelFunction = jsCancelFunction
    }
}

extension CEFMessageRouterConfig {
    func toCEF() -> cef_message_router_config_t {
        var config = cef_message_router_config_t()
        CEFStringSetFromSwiftString(jsQueryFunction, cefStringPtr: &config.js_query_function)
        CEFStringSetFromSwiftString(jsCancelFunction, cefStringPtr: &config.js_cancel_function)
        return config
    }
}
