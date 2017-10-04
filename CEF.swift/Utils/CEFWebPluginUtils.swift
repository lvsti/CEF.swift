//
//  CEFWebPluginUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFWebPluginUtils {
    
    /// Visit web plugin information. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefVisitWebPluginInfo`
    public static func enumerateWebPluginsUsingVisitor(visitor: CEFWebPluginInfoVisitor) {
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
    public static func unregisterInternalWebPluginAtPath(path: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_unregister_internal_web_plugin(cefStrPtr)
    }

    /// Register a plugin crash. Can be called on any thread in the browser process
    /// but will be executed on the IO thread.
    /// CEF name: `CefRegisterWebPluginCrash`
    public static func registerCrashForWebPluginAtPath(path: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_register_web_plugin_crash(cefStrPtr)
    }

    /// Query if a plugin is unstable. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefIsWebPluginUnstable`
    public static func isUnstableWebPluginAtPath(path: String, callback: CEFWebPluginUnstableCallback) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
    }

    /// Query if a plugin is unstable. Can be called on any thread in the browser
    /// process.
    /// CEF name: `CefIsWebPluginUnstable`
    public static func isUnstableWebPluginAtPath(path: String, block: @escaping CEFWebPluginUnstableCallbackIsUnstableBlock) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let callback = CEFWebPluginUnstableCallbackBridge(block: block)
        cef_is_web_plugin_unstable(cefStrPtr, callback.toCEF())
    }

    /// Register the Widevine CDM plugin.
    ///
    /// The client application is responsible for downloading an appropriate
    /// platform-specific CDM binary distribution from Google, extracting the
    /// contents, and building the required directory structure on the local machine.
    /// The CefBrowserHost::StartDownload method and CefZipArchive class can be used
    /// to implement this functionality in CEF. Contact Google via
    /// https://www.widevine.com/contact.html for details on CDM download.
    ///
    /// |path| is a directory that must contain the following files:
    ///   1. manifest.json file from the CDM binary distribution (see below).
    ///   2. widevinecdm file from the CDM binary distribution (e.g.
    ///      widevinecdm.dll on on Windows, libwidevinecdm.dylib on OS X,
    ///      libwidevinecdm.so on Linux).
    ///   3. widevidecdmadapter file from the CEF binary distribution (e.g.
    ///      widevinecdmadapter.dll on Windows, widevinecdmadapter.plugin on OS X,
    ///      libwidevinecdmadapter.so on Linux).
    ///
    /// If any of these files are missing or if the manifest file has incorrect
    /// contents the registration will fail and |callback| will receive a |result|
    /// value of CEF_CDM_REGISTRATION_ERROR_INCORRECT_CONTENTS.
    ///
    /// The manifest.json file must contain the following keys:
    ///   A. "os": Supported OS (e.g. "mac", "win" or "linux").
    ///   B. "arch": Supported architecture (e.g. "ia32" or "x64").
    ///   C. "x-cdm-module-versions": Module API version (e.g. "4").
    ///   D. "x-cdm-interface-versions": Interface API version (e.g. "8").
    ///   E. "x-cdm-host-versions": Host API version (e.g. "8").
    ///   F. "version": CDM version (e.g. "1.4.8.903").
    ///   G. "x-cdm-codecs": List of supported codecs (e.g. "vp8,vp9.0,avc1").
    ///
    /// A through E are used to verify compatibility with the current Chromium
    /// version. If the CDM is not compatible the registration will fail and
    /// |callback| will receive a |result| value of
    /// CEF_CDM_REGISTRATION_ERROR_INCOMPATIBLE.
    ///
    /// |callback| will be executed asynchronously once registration is complete.
    ///
    /// On Linux this function must be called before CefInitialize() and the
    /// registration cannot be changed during runtime. If registration is not
    /// supported at the time that CefRegisterWidevineCdm() is called then |callback|
    /// will receive a |result| value of CEF_CDM_REGISTRATION_ERROR_NOT_SUPPORTED.
    /// CEF name: `CefRegisterWidevineCdm`
    public func registerWidevineCDM(path: String, callback: CEFRegisterCDMCallback?) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cef_register_widevine_cdm(cefStrPtr, callback?.toCEF())
    }

        /// Register the Widevine CDM plugin.
    ///
    /// The client application is responsible for downloading an appropriate
    /// platform-specific CDM binary distribution from Google, extracting the
    /// contents, and building the required directory structure on the local machine.
    /// The CefBrowserHost::StartDownload method and CefZipArchive class can be used
    /// to implement this functionality in CEF. Contact Google via
    /// https://www.widevine.com/contact.html for details on CDM download.
    ///
    /// |path| is a directory that must contain the following files:
    ///   1. manifest.json file from the CDM binary distribution (see below).
    ///   2. widevinecdm file from the CDM binary distribution (e.g.
    ///      widevinecdm.dll on on Windows, libwidevinecdm.dylib on OS X,
    ///      libwidevinecdm.so on Linux).
    ///   3. widevidecdmadapter file from the CEF binary distribution (e.g.
    ///      widevinecdmadapter.dll on Windows, widevinecdmadapter.plugin on OS X,
    ///      libwidevinecdmadapter.so on Linux).
    ///
    /// If any of these files are missing or if the manifest file has incorrect
    /// contents the registration will fail and |callback| will receive a |result|
    /// value of CEF_CDM_REGISTRATION_ERROR_INCORRECT_CONTENTS.
    ///
    /// The manifest.json file must contain the following keys:
    ///   A. "os": Supported OS (e.g. "mac", "win" or "linux").
    ///   B. "arch": Supported architecture (e.g. "ia32" or "x64").
    ///   C. "x-cdm-module-versions": Module API version (e.g. "4").
    ///   D. "x-cdm-interface-versions": Interface API version (e.g. "8").
    ///   E. "x-cdm-host-versions": Host API version (e.g. "8").
    ///   F. "version": CDM version (e.g. "1.4.8.903").
    ///   G. "x-cdm-codecs": List of supported codecs (e.g. "vp8,vp9.0,avc1").
    ///
    /// A through E are used to verify compatibility with the current Chromium
    /// version. If the CDM is not compatible the registration will fail and
    /// |callback| will receive a |result| value of
    /// CEF_CDM_REGISTRATION_ERROR_INCOMPATIBLE.
    ///
    /// |callback| will be executed asynchronously once registration is complete.
    ///
    /// On Linux this function must be called before CefInitialize() and the
    /// registration cannot be changed during runtime. If registration is not
    /// supported at the time that CefRegisterWidevineCdm() is called then |callback|
    /// will receive a |result| value of CEF_CDM_REGISTRATION_ERROR_NOT_SUPPORTED.
    /// CEF name: `CefRegisterWidevineCdm`
    public func registerWidevineCDM(path: String, block: @escaping CEFRegisterCDMCallbackOnCDMRegistrationCompleteBlock) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(path)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let callback = CEFRegisterCDMCallbackBridge(block: block)
        cef_register_widevine_cdm(cefStrPtr, callback.toCEF())
    }

}
