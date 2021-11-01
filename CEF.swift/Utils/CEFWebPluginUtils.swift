//
//  CEFWebPluginUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFWebPluginUtils {
    
    /// Visit web plugin information. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefVisitWebPluginInfo`
    public static func enumerateWebPlugins(with visitor: CEFWebPluginInfoVisitor) {
        cef_visit_web_plugin_info(visitor.toCEF())
    }

    /// Visit web plugin information. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefVisitWebPluginInfo`
    public static func enumerateWebPlugins(block: @escaping CEFWebPluginInfoVisitorVisitBlock) {
        let visitor = CEFWebPluginInfoVisitorBridge(block: block)
        cef_visit_web_plugin_info(visitor.toCEF())
    }

    /// Cause the plugin list to refresh the next time it is accessed regardless
    /// of whether it has already been loaded. Can be called on any thread in the
    /// browser process.
    /// CEF name: `CefRefreshWebPlugins`
    public static func refreshWebPlugins() {
        cef_refresh_web_plugins()
    }

    /// Unregister an internal plugin. This may be undone the next time
    /// CefRefreshWebPlugins() is called. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefUnregisterInternalWebPlugin`
    public static func unregisterInternalWebPlugin(at path: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_unregister_internal_web_plugin(cefStrPtr)
    }

    /// Register a plugin crash. Can be called on any thread in the browser process
    /// but will be executed on the IO thread.
    /// CEF name: `CefRegisterWebPluginCrash`
    public static func registerCrashForWebPlugin(at path: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_register_web_plugin_crash(cefStrPtr)
    }

    /// Query if a plugin is unstable. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefIsWebPluginUnstable`
    public static func isUnstableWebPlugin(at path: String, callback: CEFWebPluginUnstableCallback) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
    }

    /// Query if a plugin is unstable. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefIsWebPluginUnstable`
    public static func isUnstableWebPlugin(at path: String, block: @escaping CEFWebPluginUnstableCallbackIsUnstableBlock) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let callback = CEFWebPluginUnstableCallbackBridge(block: block)
        cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
    }

}
