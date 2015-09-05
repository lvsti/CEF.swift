//
//  CEFWebPluginGlobals.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Visit web plugin information. Can be called on any thread in the browser
/// process.
public func CEFVisitWebPluginInfo(visitor: CEFWebPluginInfoVisitor) {
    cef_visit_web_plugin_info(visitor.toCEF())
}

/// Visit web plugin information. Can be called on any thread in the browser
/// process.
public func CEFVisitWebPluginInfo(block: CEFWebPluginInfoVisitorVisitBlock) {
    let visitor = CEFWebPluginInfoVisitorBridge(block: block)
    cef_visit_web_plugin_info(visitor.toCEF())
}

/// Cause the plugin list to refresh the next time it is accessed regardless
/// of whether it has already been loaded. Can be called on any thread in the
/// browser process.
public func CEFRefreshWebPlugins() {
    cef_refresh_web_plugins()
}

/// Add a plugin path (directory + file). This change may not take affect until
/// after CefRefreshWebPlugins() is called. Can be called on any thread in the
/// browser process.
public func CEFAddWebPluginPath(path: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_add_web_plugin_path(cefStrPtr)
}

/// Add a plugin directory. This change may not take affect until after
/// CefRefreshWebPlugins() is called. Can be called on any thread in the browser
/// process.
public func CEFAddWebPluginDirectory(dir: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(dir)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_add_web_plugin_directory(cefStrPtr)
}

/// Remove a plugin path (directory + file). This change may not take affect
/// until after CefRefreshWebPlugins() is called. Can be called on any thread in
/// the browser process.
public func CEFRemoveWebPluginPath(path: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_remove_web_plugin_path(cefStrPtr)
}

/// Unregister an internal plugin. This may be undone the next time
/// CefRefreshWebPlugins() is called. Can be called on any thread in the browser
/// process.
public func CEFUnregisterInternalWebPlugin(path: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_unregister_internal_web_plugin(cefStrPtr)
}

/// Force a plugin to shutdown. Can be called on any thread in the browser
/// process but will be executed on the IO thread.
public func CEFForceWebPluginShutdown(path: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_force_web_plugin_shutdown(cefStrPtr)
}

/// Register a plugin crash. Can be called on any thread in the browser process
/// but will be executed on the IO thread.
public func CEFRegisterWebPluginCrash(path: String) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_register_web_plugin_crash(cefStrPtr)
}

/// Query if a plugin is unstable. Can be called on any thread in the browser
/// process.
public func CEFIsWebPluginUnstable(path: String, callback: CEFWebPluginUnstableCallback) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
}

/// Query if a plugin is unstable. Can be called on any thread in the browser
/// process.
public func CEFIsWebPluginUnstable(path: String, block: CEFWebPluginUnstableCallbackIsUnstableBlock) {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
    defer { CEFStringPtrRelease(cefStrPtr) }
    let callback = CEFWebPluginUnstableCallbackBridge(block: block)
    cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
}

